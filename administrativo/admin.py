from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin

from .models import *

# Register your models here.
class AulaAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('aul_vcCodigo', 'aul_iCapacidad', "loc_iCodigo", "aul_vcLongitud", "aul_vcLatitud")
    search_fields = ('aul_vcCodigo',)
    list_filter = ('aul_iCapacidad',)

class LocalAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("loc_iCodigo", "loc_vcCodigo", 'loc_vcNombre')
    search_fields = ("loc_vcCodigo", 'loc_vcNombre')

class GrupoHorarioAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("gru_iCodigo", "dia_iCodigo", "gruhor_tHoraInicio", 'gruhor_tHoraFinal', "curtip_iCodigo")
    list_filter = (
    'gruhor_tHoraInicio',
    'gruhor_tHoraFinal',
    )
    search_fields = ("loc_vcCodigo", 'loc_vcNombre')

admin.site.register(Local, LocalAdmin)
admin.site.register(Aula, AulaAdmin)
admin.site.register(GrupoHorario, GrupoHorarioAdmin)