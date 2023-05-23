from django.db import models
from django.utils.translation import gettext_lazy as _
from markdown import markdown
from django.contrib.auth.models import User

# Create your models here.


class UserData(models.Model):
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    gender = models.CharField(max_length=1,choices=GENDER_CHOICES,default='M')
    age = models.IntegerField()
    phonenumber = models.IntegerField()

    # def __str__(self):
    #     return self.user

class AsrData(models.Model):
    sentence  = models.TextField()
    transcription = models.TextField()
    
    def __str__(self):
        return self.transcription
    
class UserAsrData(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    transcription = models.ForeignKey(AsrData, on_delete=models.CASCADE)
    read = models.BooleanField(default=False)

    def get_next_transcription(user):
        # get the next transcription that the user has not read yet
        user_transcriptions = UserAsrData.objects.filter(user=user)
        read_transcription_ids = user_transcriptions.values_list('transcription_id', flat=True)
        next_transcription = AsrData.objects.exclude(id__in=read_transcription_ids).order_by('?').first()
        # if next_transcription:
        #     UserAsrData.objects.create(user=user, transcription=next_transcription, read=False)
        return next_transcription


class AudioData(models.Model):
    user = models.ForeignKey(UserData,default=1,on_delete=models.CASCADE)
    transcription = models.ForeignKey(AsrData,default=1,on_delete=models.CASCADE )
    audiopath = models.CharField(max_length=250)
    processedaudio = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    points = models.IntegerField(default=0)

class prizewinner(models.Model):
    first = models.ForeignKey(UserData,default=1,on_delete=models.CASCADE,related_name='first_prizewinners')
    second = models.ForeignKey(UserData,default=1,on_delete=models.CASCADE,related_name='second_prizewinners')
    third = models.ForeignKey(UserData,default=1,on_delete=models.CASCADE,related_name='third_prizewinners')
    created_at = models.DateTimeField(auto_now_add=True)

class prize(models.Model):
    first_prize = models.IntegerField()
    second_prize = models.IntegerField()
    third_prize = models.IntegerField()
    time_of_result = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    
#documentaion 
class DocumentationPost(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title