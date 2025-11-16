from django.shortcuts import render
from django.http import HttpResponseNotFound, HttpResponseServerError
from escuela.models import Curso
from .models import Dia
from administrativo.models import Aula, GrupoHorario
import datetime
import logging

logger = logging.getLogger(__name__)

# Create your views here.
def errorPage(request, exception=None):
    """
    Maneja errores 404 y otros errores sin exponer información sensible
    """
    # Log del error para debugging interno (sin exponer al usuario)
    if exception:
        logger.error(f"Error page accessed: {exception}", exc_info=True)
    
    # Determinar el tipo de error basado en el status code
    status_code = getattr(exception, 'status_code', 404)
    
    context = {
        'error_type': 'not_found' if status_code == 404 else 'server_error',
        'status_code': status_code
    }
    
    # Renderizar template personalizado según el tipo de error
    if status_code == 404:
        return HttpResponseNotFound(render(request, '404.html', context).content)
    else:
        return HttpResponseServerError(render(request, '500.html', context).content)

def reportPage(request):
    today = datetime.datetime.now().strftime('%A')
    cursos = Curso.objects.all()
    aulas = Aula.objects.all()
    grupos = GrupoHorario.objects.all()
    dias = Dia.objects.get(dia_vcNombre=today.capitalize())

    return render(request, 'general/report.html', {})