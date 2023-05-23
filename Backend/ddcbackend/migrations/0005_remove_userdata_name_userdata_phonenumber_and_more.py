# Generated by Django 4.1.7 on 2023-04-03 17:00

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('ddcbackend', '0004_documentationpost'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userdata',
            name='name',
        ),
        migrations.AddField(
            model_name='userdata',
            name='phonenumber',
            field=models.IntegerField(default=0, max_length=8),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='userdata',
            name='user',
            field=models.OneToOneField(default=1, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]