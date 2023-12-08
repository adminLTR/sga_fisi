from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin

from .models import *
# Register your models here.

class PlanEstudioAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('plaest_vcCodigo', 'plaest_vcRR', 'plaest_iCreditos', 'plaest_bActivo', "esc_iCodigo")
    list_filter = ('plaest_bActivo', "esc_iCodigo")
    search_fields = ('plaest_vcCodigo', 'plaest_vcRR')

class CursoTipoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('curtip_iCodigo', 'curtip_vcNombre', 'curtip_bActivo')
    list_filter = ('curtip_bActivo', )
    search_fields = ('curtip_vcNombre', )

class CursoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cur_vcCodigo', 'cur_vcNombre', 'cur_fCreditos', 'cur_fCreditosRequisito', 'cur_iSemestre')
    search_fields = ('cur_vcNombre', 'cur_vcCodigo')
    list_filter = ('cur_fCreditos', 'cur_fCreditosRequisito', 'cur_iSemestre')

class CursoPrerequisitoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cur_vcNombre', 'cur_vcCodigo', 'cur_fCreditos', 'cur_fCreditosRequisito')
    ''' search_fields = ('cur_vcNombre', 'cur_vcCodigo')
    list_filter = ('cur_fCreditos', 'cur_fCreditosRequisito') '''

class CursoEquivalenteAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cureqi_iCodigo', 'cur_iCodigo', 'equ_iCodigo')
    
class GrupoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cur_iCodigo', 'gru_iNumero', 'gru_iTope')
    search_fields = ('gru_iCodigo', 'cur_iCodigo')

class CursoTipoDictadoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('curtip_vcNombre',)
    search_fields = ('curtip_vcNombre', )

class CursoHorasDictadoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cur_iCodigo', 'curhor_iHoras', 'curtip_iCodigo')
    search_fields = ('cur_iCodigo',)

class CursoPrerequisitoAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('cur_iCodigo', 'req_iCodigo',)
    search_fields = ('cur_iCodigo', 'req_iCodigo')

admin.site.register(Curso, CursoAdmin)
admin.site.register(CursoEquivalente, CursoEquivalenteAdmin)
admin.site.register(Grupo, GrupoAdmin)
admin.site.register(PlanEstudio, PlanEstudioAdmin)
admin.site.register(CursoTipo, CursoTipoAdmin)
admin.site.register(CursoTipoDictado, CursoTipoDictadoAdmin)
admin.site.register(CursoPrerequisito, CursoPrerequisitoAdmin)
admin.site.register(CursoHorasDictado, CursoHorasDictadoAdmin)
