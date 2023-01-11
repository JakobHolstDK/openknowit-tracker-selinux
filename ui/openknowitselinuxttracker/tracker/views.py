from django.shortcuts import  HttpResponse
from django.shortcuts import render

from .models import server
from .models import sealert

def detail():
    return HttpResponse()
def results():
    return HttpResponse()

def index(request):
    sealertlist = sealert.objects.order_by('Last_Seen').prefetch_related(server)[:1]
    output = ', '.join([str(q.hostname) for q in sealertlist])
    return HttpResponse(output)