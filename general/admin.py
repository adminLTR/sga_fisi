from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin

from .models import *
# Register your models here.

class FacultadAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("fac_iCodigo", "fac_vcCodigo", 'fac_vcNombre')
    search_fields = ("fac_vcCodigo", 'fac_vcNombre')

class AreaAcademicaAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("areaca_vcCodigo", 'areaca_vcNombre', 'areaca_bActivo')
    list_filter = ("areaca_bActivo", )
    search_fields = ("areaca_vcCodigo", 'areaca_vcNombre')

class EscuelaAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ("esc_vcCodigo", 'esc_vcNombre', 'esc_bActivo', "fac_iCodigo", "areaca_iCodigo")
    list_filter = ("esc_bActivo", "fac_iCodigo", "areaca_iCodigo")
    search_fields = ("esc_vcCodigo", 'esc_vcNombre')

class DiaAdmin(admin.ModelAdmin):
    list_display = ('dia_vcNombre', )

admin.site.register(Facultad, FacultadAdmin)
admin.site.register(AreaAcademica, AreaAcademicaAdmin)
admin.site.register(Escuela, EscuelaAdmin)
admin.site.register(Dia, DiaAdmin)