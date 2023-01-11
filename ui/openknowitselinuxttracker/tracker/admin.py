from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import server, sealert, known_sealert, known_sealerts

admin.site.register(server)
admin.site.register(sealert)
admin.site.register(known_sealerts)
admin.site.register(known_sealert)

