from django.db import models

# Create your models here.

# Revisado
class Facultad(models.Model):
    fac_iCodigo = models.AutoField(primary_key=True, editable=False, verbose_name="ID")
    fac_vcCodigo = models.CharField(verbose_name="Código", max_length=64, blank=False, unique=True) # Unique
    fac_vcNombre = models.CharField(verbose_name="Nombre", max_length=64, blank=False, unique=True) # Unique
    def __str__(self):
        return self.fac_vcNombre
    
    class Meta:
        verbose_name = "Facultad"
        verbose_name_plural = "Facultades"
        db_table = "facultad"

# Revisado
class AreaAcademica(models.Model):
    areaca_iCodigo = models.AutoField(primary_key=True, editable=False)
    areaca_vcCodigo = models.CharField(verbose_name="Código", max_length=4, blank=False, unique=True) # Unique
    areaca_vcNombre = models.CharField(verbose_name="Nombre", max_length=64, blank=False, unique=True) # Unique
    areaca_bActivo = models.IntegerField(verbose_name="Activo", blank=False, default=1) # TinyInt
    def __str__(self):
        return self.areaca_vcNombre
    
    class Meta:
        verbose_name = "Área académica"
        verbose_name_plural = "Áreas académicas"
        db_table = "area_academica"

# Done
class Escuela(models.Model):
    esc_iCodigo = models.AutoField(primary_key=True, editable=False)
    esc_vcCodigo = models.CharField(verbose_name="Código", max_length=16, blank=False, unique=True) # Unique
    esc_vcNombre = models.CharField(verbose_name="Nombre", max_length=96, blank=False, unique=True) # Unique
    esc_bActivo = models.IntegerField(verbose_name="Activo", blank=False, default=1) # TinyInt
    fac_iCodigo = models.ForeignKey(Facultad, on_delete=models.CASCADE, verbose_name="Facultad", blank=False)
    areaca_iCodigo = models.ForeignKey(AreaAcademica, on_delete=models.CASCADE, verbose_name="Área académica", blank=False, limit_choices_to={'areaca_bActivo': 1})
    def __str__(self):
        return self.esc_vcNombre + " - " + str(self.fac_iCodigo)
    
    class Meta:
        verbose_name = "Escuela"
        verbose_name_plural = "Escuelas"
        db_table = "escuela"

# Revisado
class Dia(models.Model):
    dia_iCodigo = models.AutoField(primary_key=True, editable=False)
    dia_iNumero = models.IntegerField(verbose_name="Número", blank=False) # Averiguar
    dia_vcNombre = models.CharField(verbose_name="Nombre", max_length=16, blank=False)
    def __str__(self):
        return self.dia_vcNombre
    
    class Meta:
        verbose_name = "Día"
        verbose_name_plural = "Días"
        db_table = "dia"