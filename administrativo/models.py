from django.db import models
from django.core.exceptions import ValidationError
# Create your models here.

# Revisado
class Local(models.Model):
    loc_iCodigo = models.AutoField(primary_key=True, verbose_name="ID", editable=False)
    loc_vcCodigo = models.CharField(verbose_name="Código", max_length=32, blank=False)
    loc_vcNombre = models.CharField(verbose_name="Nombre", max_length=64, blank=False)
    def __str__(self):
        return self.loc_vcNombre
    
    class Meta:
        verbose_name = "Local"
        verbose_name_plural = "Locales"
        db_table = "local"

# Revisado
class Aula(models.Model):
    aul_iCodigo = models.AutoField(primary_key=True, editable=False)
    aul_vcCodigo = models.CharField(verbose_name="Código", max_length=16, blank=False)
    aul_vcLongitud = models.CharField(verbose_name="Longitud", max_length=20, blank=True, null=True, default=None)
    aul_vcLatitud = models.CharField(verbose_name="Latitud", max_length=20, blank=True, null=True, default=None)
    aul_imgImage = models.ImageField(null=True, blank=True, upload_to='aulas', default=None, verbose_name="Foto")
    aul_iCapacidad = models.IntegerField(verbose_name="Capacidad", blank=False)
    loc_iCodigo = models.ForeignKey(Local, on_delete=models.CASCADE, verbose_name="Local", blank=False)

    def __str__(self):
        return self.aul_vcCodigo
    
    class Meta:
        verbose_name = "Aula"
        verbose_name_plural = "Aulas"
        db_table = "aula"

# Revisado
class GrupoHorario(models.Model):
    gruhor_iCodigo = models.AutoField(primary_key=True, editable=False)
    gru_iCodigo = models.ForeignKey('escuela.Grupo', on_delete=models.CASCADE, verbose_name="Grupo", blank=False)
    dia_iCodigo = models.ForeignKey('general.Dia', on_delete=models.CASCADE, verbose_name="Día", blank=False)
    aul_iCodigo = models.ForeignKey(Aula, on_delete=models.CASCADE, verbose_name="Aula", blank=False)
    curtip_iCodigo = models.ForeignKey('escuela.CursoTipoDictado', on_delete=models.CASCADE, verbose_name="Tipo de dictado", blank=False)

    gruhor_tHoraInicio = models.TimeField(verbose_name="Hora de inicio", blank=False)
    gruhor_tHoraFinal = models.TimeField(verbose_name="Hora de finalización", blank=False)

    def clean(self):
        registros_existentes = GrupoHorario.objects.exclude(pk=self.gruhor_iCodigo).filter(
            dia_iCodigo=self.dia_iCodigo,
            aul_iCodigo=self.aul_iCodigo, 
        )

        for registro in registros_existentes:
            if (
                self.gruhor_tHoraInicio >= registro.gruhor_tHoraInicio and
                self.gruhor_tHoraInicio < registro.gruhor_tHoraFinal
            ) or (
                self.gruhor_tHoraFinal > registro.gruhor_tHoraInicio and
                self.gruhor_tHoraFinal <= registro.gruhor_tHoraFinal
            ):
                raise ValidationError('El horario se cruza con otro registro existente.')

    def __str__(self):
        return str(self.gru_iCodigo)+", "+str(self.dia_iCodigo)+", "+str(self.aul_iCodigo)+", "+str(self.curtip_iCodigo)
    
    class Meta:
        verbose_name = "Grupo horario"
        verbose_name_plural = "Grupos horario"
        db_table = "grupo_horario"
