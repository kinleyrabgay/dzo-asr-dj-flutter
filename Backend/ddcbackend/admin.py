from django.contrib import admin
from . import models
# Register your models here.
admin.site.register(models.UserData)
admin.site.register(models.AsrData)
admin.site.register(models.AudioData)
admin.site.register(models.DocumentationPost)
admin.site.register(models.UserAsrData)
admin.site.register(models.prize)
admin.site.register(models.prizewinner)