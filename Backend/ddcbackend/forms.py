from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from django.contrib.auth.forms import AuthenticationForm
from . import models

# Create your forms here.

class NewUserForm(UserCreationForm):
	email = forms.EmailField(required=True)
	
	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['username'].widget.attrs.update({'placeholder': 'User Name','class':"login__input"})
		self.fields['email'].widget.attrs.update({'placeholder': 'Email','class':"login__input"})
		self.fields['password1'].widget.attrs.update({'placeholder': 'Password','class':"login__input"})
		self.fields['password2'].widget.attrs.update({'placeholder': 'Confirm Password','class':"login__input"})

	class Meta:
		model = User
		fields = ("username", "email", "password1", "password2")

	def save(self, commit=True):
		user = super(NewUserForm, self).save(commit=False)
		user.email = self.cleaned_data['email']
		if commit:
			user.save()
			group = Group.objects.get(name='databaseadmin')
			user.groups.add(group)
		return user
	
class CustomLoginForm(AuthenticationForm):
	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['username'].widget.attrs.update({'placeholder': 'User Name','class':"login__input"})
		self.fields['password'].widget.attrs.update({'placeholder': 'Password','class':"login__input"})



class DocumentationForm(forms.ModelForm):
    class Meta:
        model = models.DocumentationPost
        fields = ['title', 'content']
	
class PrizeForm(forms.ModelForm):
    class Meta:
        model = models.prize
        fields = ['first_prize', 'second_prize','third_prize','time_of_result']