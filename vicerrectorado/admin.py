from django.contrib import admin

from import_export import resources
from import_export.admin import ImportExportModelAdmin

from .models import *

# Register your models here.
class SemestreAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("sem_iCodigo", "sem_vcCodigo", 'sem_cActivo')
    search_fields = ('sem_vcCodigo', )
    list_filter = ('sem_cActivo',)

admin.site.register(Semestre, SemestreAdmin)
