from django.urls import path

from . import views

urlpatterns = [
    # ex: /polls/
    path('', views.index, name='index'),
    # ex: /polls/5/
    path('<int:server_id>/', views.detail, name='detail'),
    # ex: /polls/5/results/
    path('<int:server_id>/results/', views.results, name='results'),
]