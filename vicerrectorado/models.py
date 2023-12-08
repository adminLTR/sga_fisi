from django.db import models
from django.core.exceptions import ValidationError

# Create your models here.

# Revisado
class Semestre(models.Model):
    sem_iCodigo = models.AutoField(primary_key=True, verbose_name="ID", editable=False)
    sem_vcCodigo = models.CharField(verbose_name="Código", blank=False, max_length=8)
    sem_cActivo = models.CharField(verbose_name="Activo", choices = (('S', 'Sí'),('N', 'No')), blank=False, default='N', max_length=1)
    def __str__(self):
        return "Semestre "+self.sem_vcCodigo
    
    def clean(self) -> None:
        registros = Semestre.objects.exclude(pk=self.sem_iCodigo)
        for i in registros:
            if i.sem_cActivo=='S':
                raise ValidationError('Solo puede haber un periodo activo')

    class Meta:
        verbose_name = "Semestre"
        verbose_name_plural = "Semestres"
        db_table = "semestre"
