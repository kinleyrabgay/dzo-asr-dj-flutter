import django


from django.urls import path
from . import views

urlpatterns= [
    
    path('signin',views.signin,name="signin"),
    path('signup',views.signup,name="signup"),
    path('logout',views.logout_user,name="logout"),

    path('setlang/<int:pk>',views.setlang,name="setlang"),
    path('home',views.home,name="home"),
    path('test_model',views.test_model,name="test_model"),
    path('about',views.about,name="about"),
    path('transcribe_audio',views.transcribe_audio,name="transcribe_audio"),
    path('transcribe_audio_withLM',views.transcribe_audio_withLM,name="transcribe_audio_withLM"),
    path('view_documentation',views.view_documentation,name="view_documentation"),
    path('view_documentation/<int:pk>',views.view_documentation_id,name="view_documentation_id"),
    # path('view_documentation_detail/<int:pk>',views.view_documentation_detail,name="view_documentation_detail"),


    path('dashboard', views.dashboard, name='dashboard'),
    path('audio', views.audio, name='audio'),
    path('mark_audio_processed', views.markaudioprocessed, name='mark_audio_processed'),
    path('mark_audio_unprocessed', views.markaudiounprocessed, name='mark_audio_unprocessed'),
    path('reject_audio', views.rejectaudio, name='reject_audio'),
    path('processedaudio', views.processedaudio, name='processedaudio'),
    path('view-transcriptions', views.viewtranscriptions, name='view-transcriptions'),
    path('prize', views.prize, name='prize'),
    path('create_documentation_post',views.create_documentation_post,name="create_documentation_post"),
    path('create_documentation_post_id/<int:pk>',views.create_documentation_post_id,name="create_documentation_post_id"),
    # path('user/', views.UserRecordView.as_view(), name='users'),
    path('getasrdata/<int:pk>',views.AsrDataList.as_view()),
    


    #API EndPoints
    path('register-mobile-user',views.register_view),
    path('login-mobile-user',views.login_view),
    path('prize-winner',views.prize_winner),
    path('next_transcription/<int:userid>/',views.next_transcription),
    path('mark-transcription-as-read/<int:user_id>/<int:transcription_id>/',views.mark_transcription_as_read),
    path('upload/', views.AudioUploadView.as_view()),
    path('transcribe-audio/', views.AudioTranscribeView.as_view()),
]   