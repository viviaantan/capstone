from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.test, name="test"),
    path('part1', views.test2, name="test2"),
    #path('part1', views.test, name="test"),
]