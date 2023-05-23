import json
import os
from pydub import AudioSegment
from django.core.files.storage import default_storage
from django.http import HttpResponse,JsonResponse

from django.shortcuts import render, HttpResponse,redirect,get_object_or_404
import pandas as pd
from django.contrib.auth.models import User
from django.contrib.auth.decorators import user_passes_test,login_required
from .forms import NewUserForm,CustomLoginForm,DocumentationForm , PrizeForm
from . import models
from ddcbackend.serializer.serializer import AsrDataSerializer, UserSerializer,AudioSerializer,PrizeSerializer,WinnersSerializer
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.permissions import IsAdminUser
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from django.conf import settings
from django.core.files.storage import FileSystemStorage
from .predict import process_audio
from django.contrib.auth import login,authenticate,logout
from django.contrib import messages
from django.contrib.auth.forms import AuthenticationForm
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import AllowAny
from django.forms.models import model_to_dict
from datetime import datetime,timezone




gobal_context={
 "current_lang":'eng',
}

# Create your views here.

def setlang(request,pk):
	
	if pk==1:
		print(pk)
		gobal_context['current_lang']='dzo'
	else:
		gobal_context['current_lang']='eng'
	return render(request, 'ddcbackend/home.html',gobal_context)


def home(request):
	return render(request, 'ddcbackend/home.html',gobal_context)

def about(request):
	return render(request, 'ddcbackend/about.html')

def test_model(request):
	return render(request, 'ddcbackend/testmodel.html')

def signin(request):
	if request.method == "POST":
		form = CustomLoginForm(request, data=request.POST)
		if form.is_valid():
			username = form.cleaned_data.get('username')
			password = form.cleaned_data.get('password')
			user = authenticate(username=username, password=password)
			if user is not None:
				login(request, user)
				messages.info(request, f"You are now logged in as {username}.")
				return render(request, 'ddcbackend/admin/dashboardhome.html')
			else:
				messages.error(request,"Invalid username or password.")
		else:
			messages.error(request,"Invalid username or password.")
	form = CustomLoginForm()
	
	return render(request, 'ddcbackend/signin.html',{"login_form":form})

def signup(request):
	if request.method == "POST":
		print(request.POST)
		form = NewUserForm(request.POST)
		if form.is_valid():
			user = form.save()
			login(request, user)
			messages.success(request, "Registration successful." )
			return render(request, 'ddcbackend/admin/dashboardhome.html')
		
		print(form.errors)
		
		messages.error(request, "Unsuccessful registration. Invalid information.")
		return render(request, 'ddcbackend/signup.html',{"register_form":form})
	form = NewUserForm()
	return render(request, 'ddcbackend/signup.html',{"register_form":form})

def logout_user(request):
	logout(request)
	messages.info(request, "You have successfully logged out.") 
	return redirect("home")


@login_required
def dashboard(request):
	recent_audio = models.AudioData.objects.order_by('-created_at')[:5]
	return render(request, 'ddcbackend/admin/dashboardhome.html',{"recent_audio":recent_audio,})

@login_required
def audio(request):
	# audiodata = models.AudioData.objects.all()
	unprocessed_data = models.AudioData.objects.filter(processedaudio=False)

	# for x in audiodata:
	# 	print(x.user.gender)
	# print(audiodata)
	return render(request, 'ddcbackend/admin/audio.html',{'audiodata': unprocessed_data})

def markaudioprocessed(request):
	if request.method == 'POST':
		jsonData = json.loads(request.body)
		audio_id = jsonData.get('audio_id')
		audio_data = models.AudioData.objects.get(id=audio_id)
		audio_data.processedaudio = True
		audio_data.save()
		return JsonResponse({'status': 'success'})
	else:
		return JsonResponse({'status': 'error'})

@login_required
def processedaudio(request):
	processed_data = models.AudioData.objects.filter(processedaudio=True)
	return render(request, 'ddcbackend/admin/processedaudio.html',{'audiodata':processed_data})

#mark the audio unprocessed 
def markaudiounprocessed(request):
	if request.method == 'POST':
		jsonData = json.loads(request.body)
		audio_id = jsonData.get('audio_id')
		audio_data = models.AudioData.objects.get(id=audio_id)
		audio_data.processedaudio = False
		audio_data.save()
		return JsonResponse({'status': 'success'})
	else:
		return JsonResponse({'status': 'error'})


def rejectaudio(request):
	if request.method == 'POST':
		jsonData = json.loads(request.body)
		audio_id = jsonData.get('audio_id')
		try:
			audio_data = models.AudioData.objects.get(id=audio_id)
		except models.AudioData.DoesNotExist:
			return JsonResponse({'status': 'error', 'message': f'AudioData with ID {audio_id} does not exist'})
		audio_data.delete() 
		
		return JsonResponse({'status': 'success'})
	else:
		return JsonResponse({'status': 'error'})
	
	
@login_required
def viewtranscriptions(request):
	transcriptions = models.AsrData.objects.all()
	if request.method == 'POST':
		file = request.FILES['file']
		data = pd.read_excel(file)

		for index, row in data.iterrows():
			models.AsrData.objects.create(
				sentence=row['sentence'],
				transcription=row['transcription'],
			)

		return render(request, 'ddcbackend/admin/transcription.html', {'success': True,'transcriptions': transcriptions})

	return render(request, 'ddcbackend/admin/transcription.html',{'success': False,'transcriptions': transcriptions})

@login_required
def prize(request):
	winners = models.prizewinner.objects.all()
	prize = models.prize.objects.latest('created_at')

	# datetime_object = datetime.strptime(prize.time_of_result, "%B %d, %Y, %I:%M %p")
	current_datetime = datetime.now(timezone.utc)  
	remaining_time = prize.time_of_result - current_datetime

	print(prize.first_prize)
	if request.method == "POST":
		print(request.POST)
		form = PrizeForm(request.POST)
		if form.is_valid():
			form.save()
			newform = PrizeForm()
			return render(request, 'ddcbackend/admin/prize.html',{"prize_form":newform, 'winners':winners,'prize':prize,'remaining_time':remaining_time})
		print(form.errors)
		return render(request, 'ddcbackend/admin/prize.html',{"prize_form":form,'winners':winners,'prize':prize,'remaining_time':remaining_time})
	form = PrizeForm()
	return render(request, 'ddcbackend/admin/prize.html',{"prize_form":form,'winners':winners,'prize':prize,'remaining_time':remaining_time})



def transcribe_audio(request):
	if request.method == 'POST' and request.FILES['audio_input']:
		audio_file = request.FILES['audio_input']
		# check file size and format
		# if audio_file.size > settings.MAX_AUDIO_SIZE:
		# 	print(audio_file.size)
		# 	return render(request, 'ddcbackend/home.html', {'error': 'File is too large.'})
		# if not audio_file.name.endswith('.mp3'):
		#     print(audio_file.size)
		#     return render(request, 'ddcbackend/home.html', {'error': 'File is not an MP3.'})
		# save the file to a storage location

		fs = FileSystemStorage()
		filename = fs.save(audio_file.name, audio_file)
		file_url = fs.url(filename)

		transcribed_text=process_audio('media/'+filename,1)

		# store the file path or URL in your database or any data storage you use
		# ...
		return render(request, 'ddcbackend/home.html',{"transcribed_text":transcribed_text,"audio_file_url":file_url})
	return render(request, 'ddcbackend/home.html')


def transcribe_audio_withLM(request):
	print(request.FILES['audio_input'])
	if request.method == 'POST' and request.FILES['audio_input']:
		audio_file = request.FILES['audio_input']
	
		model = request.POST['selectmodel']
		print(model)
		fs = FileSystemStorage()
		filename = fs.save(audio_file.name, audio_file)
		file_url = fs.url(filename)

		transcribed_text=process_audio('media/'+filename,model)

		print("transcribed_text",transcribed_text)

		# store the file path or URL in your database or any data storage you use
		# ...
		# return render(request, 'ddcbackend/testmodel.html',{"transcribed_text":transcribed_text,"audio_file_url":file_url})
		return JsonResponse({'transcription': transcribed_text})
	return render(request, 'ddcbackend/testmodel.html')




@login_required
def create_documentation_post(request):
	if request.method == 'POST':
		form = DocumentationForm(request.POST)
		if form.is_valid():
			post = form.save()
			emptyform = DocumentationForm()
			return render(request, 'ddcbackend/admin/createdoc.html', {'form': emptyform})
			# return redirect('post_detail', pk=post.pk)
	else:
		form = DocumentationForm()
	return render(request, 'ddcbackend/admin/createdoc.html', {'form': form})
	# return render(request, 'ddcbackend/adddocumentation.html', {'form': form})


@login_required
def create_documentation_post_id(request,pk):
	postscontent = models.DocumentationPost.objects.get(pk=pk)
	if request.method == 'POST':
		form = DocumentationForm(request.POST, instance=postscontent)
		if form.is_valid():
			form.save()
			return redirect('view_documentation_id', pk=pk)
	else:
		initial_data = {'title': postscontent.title} 
		form = DocumentationForm(initial=initial_data)
	return render(request, 'ddcbackend/admin/createdoc.html', {'form': form,"postscontent":postscontent.content })


def view_documentation(request):
	posts = models.DocumentationPost.objects.all()
	postscontent = models.DocumentationPost.objects.first()
	return render(request, 'ddcbackend/viewdocumentation.html', {'posts': posts, "postscontent":postscontent.content })

def view_documentation_id(request,pk):
	posts = models.DocumentationPost.objects.all()
	postscontent = models.DocumentationPost.objects.get(pk=pk)
	return render(request, 'ddcbackend/viewdocumentation.html', {'posts': posts, "postscontent":postscontent.content })

# def view_documentation_detail(request, pk):
# 	# posts = get_object_or_404(models.DocumentationPost, pk=pk)
# 	posts = models.DocumentationPost.objects.get(pk=pk)
# 	print(posts.content)
# 	return render(request, 'ddcbackend/viewdocumentation_detail.html', {'posts': str(posts.content),"postscontent":posts.content})



#api Endpoints for mobile applications_________________________________________________________________________

class AsrDataList(generics.RetrieveAPIView):
	serializer_class = AsrDataSerializer
	def get_queryset(self):
		pk = self.kwargs.get('pk')
		return models.AsrData.objects.filter(id=pk)


@api_view(['POST'])
def register_view(request):
	serializer = UserSerializer(data=request.data)
	if serializer.is_valid():
		user = serializer.save()
		login(request, user)
		return Response({'message':'success','user': UserSerializer(user).data,"user_id":user.id})
	else:
		return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def login_view(request):
	username = request.data.get('username')
	password = request.data.get('password')
	
	

	print(username, password)
	user = authenticate(request, username=username, password=password)
	print(user)
	if user is not None:
		login(request, user)
		return Response({'message':'success','user': UserSerializer(user).data,"user_id":user.id})
	else:
		return Response({'message': 'fail'}, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def next_transcription(request, userid):
	
	print(userid)
	
	user = User.objects.get(id=userid)
	next_transcription = models.UserAsrData.get_next_transcription(user)
	context = {
		'message': 'success',
		'next_transcription': model_to_dict(next_transcription),
	}
	return Response(context)

@api_view(['GET'])
def mark_transcription_as_read(request, user_id, transcription_id):
	next_transcription = get_object_or_404(models.AsrData, id=transcription_id)
	user = User.objects.get(id=user_id)
	models.UserAsrData.objects.create(user=user, transcription=next_transcription, read=True)
	return Response({'success': True, 'user_id': user_id, 'transcription_id': transcription_id})

@api_view(['GET'])
def prize_winner(request):
	winners = models.prizewinner.objects.latest('created_at')
	print(winners)
	prize = models.prize.objects.latest('created_at')
	winner_serializer = WinnersSerializer(winners)
	serialized_winner = winner_serializer.data
	prize_serializer = PrizeSerializer(prize)
	serialized_prize = prize_serializer.data

	return Response({'success': True, "prize":serialized_prize ,'winners':serialized_winner})


class AudioUploadView(APIView):
	def post(self, request, format=None):
		serializer = AudioSerializer(data=request.data)
		if serializer.is_valid():
			print(serializer.validated_data)
			audio_file = serializer.validated_data['audio']
			user_id = request.POST.get('user_id')
			transcription_id = request.POST.get('transcription_id')

			print(user_id,transcription_id)
			current_datetime = datetime.now()
			current_datetime_str = current_datetime.strftime("%Y%m%d_%H%M%S")
			audip_path = 'media/audio/'+current_datetime_str+'.ogg'
			# transcribed_text=process_audio(audio_file)
			with open(audip_path, 'wb') as f:
				f.write(audio_file.read())
			

			audio_data = models.AudioData()
			audio_data.audiopath = audip_path
			audio_data.user_id = user_id
			audio_data.transcription_id = transcription_id
			audio_data.save()
			# transcribed_text=process_audio("media/audio.mp3")
			return Response({'message': 'Audio uploaded successfully'})
		else:
			return Response(serializer.errors, status=400)


class AudioTranscribeView(APIView):
	def post(self, request, format=None):
		serializer = AudioSerializer(data=request.data)
		if serializer.is_valid():
			audio_file = serializer.validated_data['audio']

	
			print(audio_file)
			
			with open('media/audio/audio.ogg', 'wb') as f:
				f.write(audio_file.read())
				
			transcribed_text=process_audio('media/audio/audio.ogg',2)
			return Response({'message': 'Audio transcribed successfully',"transcription":transcribed_text})
		else:
			return Response(serializer.errors, status=400)
		
