from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path('',include('capstone_backendApp.urls')),
    path('part1',include('capstone_backendApp.urls')),
    #path('part2',include('capstone_backendApp.urls'))
]
