from django.db import models
from django.utils import timezone

class server(models.Model):
    hostname = models.CharField(max_length=200, unique=True)
    SEstatus = models.CharField(max_length=20)
    localpolicies = models.BooleanField(default=False)
    description = models.CharField(max_length=4096)
    def __unicode__(self):
        return u'%s' % (self.hostname)

class sealert(models.Model):
    Source_Context = models.CharField(max_length=1024)
    Target_Context = models.CharField(max_length=1024)
    Target_Objects = models.CharField(max_length=1024)
    Source = models.CharField(max_length=1024)                 
    Source_Path = models.CharField(max_length=1024)            
    Port  = models.CharField(max_length=32)                        
    Host  = models.CharField(max_length=256) 
    Source_RPM_Packages = models.CharField(max_length=1024)
    Target_RPM_Packages = models.CharField(max_length=1024)
    First_Seen = models.DateTimeField()
    Last_Seen  = models.DateTimeField()
    Local_ID = models.CharField(max_length=1024, unique=True)
    Raw_Audit_Messages = models.CharField(max_length=4096)
    hostname = models.ForeignKey(server, on_delete=models.CASCADE)

class known_sealert(models.Model):
    name = models.CharField(max_length=128)
    description = models.CharField(max_length=4096)
    digestkey = models.CharField(max_length=1024)
    def __unicode__(self):
        return u'%s' % (self.name)

class known_sealerts(models.Model):
    knownalertname = models.ForeignKey(known_sealert, on_delete=models.CASCADE)
    digest = models.CharField(max_length=255, unique=True)
    snoozed_untild = models.DateTimeField()
    riskassement = models.CharField(max_length=50)

    
