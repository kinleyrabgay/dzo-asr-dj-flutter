
from django.contrib.auth import authenticate
from django.contrib.auth.models import User , Group

from django.contrib.auth.password_validation import validate_password
from .. import models 

from rest_framework import serializers

class UserDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserData
        fields = ['gender', 'age','phonenumber']


class UserSerializer(serializers.ModelSerializer):

    userdata = UserDataSerializer()

    class Meta:
        model = User
        fields = ['id', 'password','username','email', 'userdata']

    def create(self, validated_data):
        user_data = validated_data.pop('userdata')
        user = User.objects.create_user(**validated_data)
        models.UserData.objects.create(user=user, **user_data)
        return user

class AsrDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.AsrData
        fields = '__all__'


class AudioSerializer(serializers.Serializer):
    audio = serializers.FileField()

class PrizeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.prize
        fields = ['first_prize','second_prize','third_prize','time_of_result']


class WinnersSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.prizewinner
        fields = ['first','second','third']