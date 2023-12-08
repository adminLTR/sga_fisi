from django.shortcuts import render
from escuela.models import Curso
from .models import Dia
from administrativo.models import Aula, GrupoHorario
import datetime

# Create your views here.
def errorPage(request, exception=None):
    return render(request, 'general/error.html', {})

def reportPage(request):
    today = datetime.datetime.now().strftime('%A')
    cursos = Curso.objects.all()
    aulas = Aula.objects.all()
    grupos = GrupoHorario.objects.all()
    dias = Dia.objects.get(dia_vcNombre=today.capitalize())

    return render(request, 'general/report.html', {})