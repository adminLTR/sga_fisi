from django.db import models
from datetime import *
from django.core.exceptions import ValidationError
# Create your models here.

# Revisado
class PlanEstudio(models.Model):
    plaest_iCodigo = models.AutoField(primary_key=True, editable=False)
    plaest_vcCodigo = models.CharField(verbose_name="Código", max_length=8, blank=False, unique=True) # Unique
    plaest_vcRR = models.CharField(verbose_name="Resolución rectoral", max_length=16, blank=False)
    plaest_dVigencia = models.DateTimeField(default=datetime.now, blank=True)

    plaest_iCreditos = models.IntegerField(verbose_name="Créditos", blank=True, default=0) # TinyInt
    plaest_bActivo = models.IntegerField(verbose_name="Activo", blank=False, default=1) # TinyInt
    esc_iCodigo = models.ForeignKey('general.Escuela', on_delete=models.CASCADE, verbose_name="Escuela", blank=False, limit_choices_to={'esc_bActivo': 1})
    
    def __str__(self):
        return self.plaest_vcCodigo
    
    class Meta:
        verbose_name = "Plan de estudio"
        verbose_name_plural = "Planes de estudio"
        db_table = "plan_estudio"


# Revisado
class CursoTipo(models.Model):
    curtip_iCodigo = models.AutoField(primary_key=True, editable=False)
    curtip_vcNombre = models.CharField(verbose_name="Nombre", max_length=32, blank=False, unique=True) # Unique
    curtip_bActivo = models.IntegerField(verbose_name="Activo", blank=False, default=1)
    
    def __str__(self):
        return self.curtip_vcNombre
    
    class Meta:
        verbose_name = "Tipo de curso"
        verbose_name_plural = "Tipos de curso"
        db_table = "curso_tipo"

# Revisado
class Curso(models.Model):
    cur_iCodigo = models.AutoField(primary_key=True, editable=False)
    cur_vcCodigo = models.CharField(verbose_name="Código", max_length=16)
    cur_vcNombre = models.CharField(verbose_name="Nombre", max_length=64)
    cur_fCreditos = models.DecimalField(verbose_name="Créditos", max_digits=6, decimal_places=1)
    cur_fCreditosRequisito = models.DecimalField(verbose_name="Créditos requeridos", max_digits=6, decimal_places=1, default=0.0)
    cur_iSemestre = models.IntegerField(verbose_name="Semestre", blank=True, null=True) # Nullable


    #plaest_iCodigo = models.IntegerField(verbose_name="Plan de estudios", blank=False)
    #curtip_iCodigo = models.IntegerField(verbose_name="Tipo de curso", blank=False)
    #curare_iCodigo = models.IntegerField(verbose_name="Área académica", blank=False)
    
    plaest_iCodigo = models.ForeignKey(PlanEstudio, on_delete=models.CASCADE, verbose_name="Plan de estudio", blank=False, limit_choices_to={'plaest_bActivo': 1})
    curtip_iCodigo = models.ForeignKey(CursoTipo, on_delete=models.CASCADE, verbose_name="Tipo de acceso", blank=False, limit_choices_to={'curtip_bActivo': 1})
    curare_iCodigo = models.ForeignKey('general.AreaAcademica', on_delete=models.CASCADE, verbose_name="Área académica", blank=False, limit_choices_to={'areaca_bActivo': 1})
    
    def __str__(self):
        return str(self.plaest_iCodigo)+", "+self.cur_vcCodigo+", "+self.cur_vcNombre
    
    class Meta:
        verbose_name = "Curso"
        verbose_name_plural = "Cursos"
        db_table = "curso"

# Revisado
class CursoPrerequisito(models.Model):
    curpre_iCodigo = models.AutoField(primary_key=True, editable=False)
    cur_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, verbose_name="Curso", blank=False)
    req_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, related_name='req_iCodigo', verbose_name="Requisito", blank=False)
    def __str__(self):
        return str(self.cur_iCodigo)+", "+str(self.req_iCodigo)
    
    def clean(self):
        if self.cur_iCodigo == self.req_iCodigo:
            raise ValidationError('Un curso no puede ser prerequisito de sí mismo')
        registros = CursoPrerequisito.objects.all()
        for registro in registros:
            if registro.cur_iCodigo==self.cur_iCodigo and registro.req_iCodigo==self.req_iCodigo:
                raise ValidationError('Ya se registró ese prerequisito')
    
    class Meta:
        verbose_name = "Pre requisito"
        verbose_name_plural = "Prerequisitos"
        db_table = "curso_prerequisito"

# Revisado
class CursoEquivalente(models.Model):
    cureqi_iCodigo = models.AutoField(primary_key=True, editable=False, verbose_name="ID")
    cur_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, verbose_name="Curso", blank=False)
    equ_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, related_name='equ_iCodigo', verbose_name="Curso equivalente", blank=False)
    def __str__(self):
        return str(self.cur_iCodigo)+", "+str(self.equ_iCodigo)

    def clean(self):
        if self.cur_iCodigo == self.equ_iCodigo:
            raise ValidationError('Un curso no puede ser prerequisito de sí mismo')
        registros = CursoEquivalente.objects.all()
        for registro in registros:
            if registro.cur_iCodigo==self.cur_iCodigo and registro.equ_iCodigo==self.equ_iCodigo:
                raise ValidationError('Ya se registró esa equivalencia')
    
    class Meta:
        verbose_name = "Curso equivalente"
        verbose_name_plural = "Cursos equivalentes"
        db_table = "curso_equivalente"

# Revisado
class Grupo(models.Model):
    gru_iCodigo = models.AutoField(primary_key=True, editable=False)
    sem_iCodigo = models.ForeignKey('vicerrectorado.Semestre', on_delete=models.CASCADE, verbose_name="Semestre", blank=False, limit_choices_to={'sem_cActivo': 'S'})
    cur_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, verbose_name="Curso", blank=False)
    gru_iNumero = models.IntegerField(verbose_name="Número de grupo", blank=False)
    gru_iTope = models.IntegerField(verbose_name="Tope de alumnos", blank=False, default=0)
    def __str__(self):
        return str(self.sem_iCodigo)+", "+str(self.cur_iCodigo)+str(self.gru_iNumero)
    
    def clean(self) -> None:
        if self.gru_iNumero<=0 or self.gru_iTope<0:
            raise ValidationError('No se puede insertar numeros negativos')
        registros_existentes = Grupo.objects.exclude(pk=self.gru_iCodigo).filter(
            sem_iCodigo=self.sem_iCodigo,
            cur_iCodigo=self.cur_iCodigo, 
        )

        last = max([group.gru_iNumero for group in registros_existentes])
        if last+1<self.gru_iNumero:
            raise ValidationError(f'No se puede crear el grupo {self.gru_iNumero} antes que el grupo {last+1}')

    class Meta:
        verbose_name = "Grupo"
        verbose_name_plural = "Grupos"
        db_table = "grupo"

# Revisado
class CursoTipoDictado(models.Model):
    curtip_iCodigo = models.AutoField(primary_key=True, editable=False)
    curtip_vcNombre = models.CharField(verbose_name="Nombre", max_length=16, blank=False)
    def __str__(self):
        return self.curtip_vcNombre
    
    class Meta:
        verbose_name = "Tipo de dictado"
        verbose_name_plural = "Tipos de dictado"
        db_table = "curso_tipodictado"

# Revisado
class CursoHorasDictado(models.Model):
    curhor_iCodigo = models.AutoField(primary_key=True, editable=False)
    curhor_iHoras = models.IntegerField(verbose_name="Horas", blank=False)
    cur_iCodigo = models.ForeignKey(Curso, on_delete=models.CASCADE, verbose_name="Curso", blank=False)
    curtip_iCodigo = models.ForeignKey(CursoTipoDictado, on_delete=models.CASCADE, verbose_name="Tipo de dictado del curso", blank=False)
    def __str__(self):
        return str(self.cur_iCodigo)+str(self.curhor_iHoras)+str(self.curtip_iCodigo)
    
    class Meta:
        verbose_name = "Horas de dictado de curso"
        verbose_name_plural = "Horas de dictado de cursos"
        db_table = "curso_horasdictado"
