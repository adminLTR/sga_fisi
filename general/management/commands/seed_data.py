"""
Comando Django para poblar la base de datos con datos iniciales usando upsert.
Este comando se ejecuta automáticamente al levantar el contenedor Docker.
"""
from django.core.management.base import BaseCommand
from django.db import transaction
from general.models import Facultad, AreaAcademica, Escuela, Dia
from vicerrectorado.models import Semestre
from administrativo.models import Local, Aula, GrupoHorario
from escuela.models import (
    PlanEstudio, CursoTipo, Curso, CursoTipoDictado, 
    CursoHorasDictado, CursoPrerequisito, CursoEquivalente, Grupo
)
from datetime import datetime, time


class Command(BaseCommand):
    help = 'Poblar la base de datos con datos iniciales usando upsert'

    def handle(self, *args, **kwargs):
        self.stdout.write(self.style.SUCCESS('Iniciando carga de datos...'))
        
        try:
            with transaction.atomic():
                self.seed_facultades()
                self.seed_areas_academicas()
                self.seed_escuelas()
                self.seed_dias()
                self.seed_semestres()
                self.seed_locales()
                self.seed_aulas()
                self.seed_tipos_curso()
                self.seed_planes_estudio()
                self.seed_cursos()
                self.seed_tipos_dictado()
                self.seed_horas_dictado()
                self.seed_grupos()
                self.seed_grupo_horarios()
                
            self.stdout.write(self.style.SUCCESS('\n✓ ¡Todos los datos cargados exitosamente!'))
            
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'✗ Error al cargar datos: {str(e)}'))
            # No hacer raise para que el contenedor continue iniciando
            self.stdout.write(self.style.WARNING('⚠ Continuando con el inicio del servidor...'))

    def seed_facultades(self):
        """Poblar tabla de Facultades"""
        self.stdout.write('Cargando Facultades...')
        
        facultades = [
            {'fac_vcCodigo': 'FISI', 'fac_vcNombre': 'Fac. Ing. Sistemas e Informática'},
            {'fac_vcCodigo': 'FIM', 'fac_vcNombre': 'Fac. Ingeniería Mecánica'},
            {'fac_vcCodigo': 'FIEE', 'fac_vcNombre': 'Fac. Ing. Eléctrica y Electrónica'},
            {'fac_vcCodigo': 'FIGMM', 'fac_vcNombre': 'Fac. Ing. Geológica, Minera y Metalúrgica'},
            {'fac_vcCodigo': 'FIQ', 'fac_vcNombre': 'Fac. Ing. Química y Textil'},
            {'fac_vcCodigo': 'FC', 'fac_vcNombre': 'Facultad de Ciencias'},
            {'fac_vcCodigo': 'FIA', 'fac_vcNombre': 'Fac. Ingeniería Ambiental'},
            {'fac_vcCodigo': 'FIIS', 'fac_vcNombre': 'Fac. Ing. Industrial y de Sistemas'},
        ]
        
        for data in facultades:
            Facultad.objects.update_or_create(
                fac_vcCodigo=data['fac_vcCodigo'],
                defaults={'fac_vcNombre': data['fac_vcNombre']}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(facultades)} facultades cargadas'))

    def seed_areas_academicas(self):
        """Poblar tabla de Áreas Académicas"""
        self.stdout.write('Cargando Áreas Académicas...')
        
        areas = [
            {'areaca_vcCodigo': 'INF', 'areaca_vcNombre': 'Informática', 'areaca_bActivo': 1},
            {'areaca_vcCodigo': 'MAT', 'areaca_vcNombre': 'Matemáticas', 'areaca_bActivo': 1},
            {'areaca_vcCodigo': 'FIS', 'areaca_vcNombre': 'Física', 'areaca_bActivo': 1},
            {'areaca_vcCodigo': 'HUM', 'areaca_vcNombre': 'Humanidades', 'areaca_bActivo': 1},
            {'areaca_vcCodigo': 'ING', 'areaca_vcNombre': 'Ingeniería', 'areaca_bActivo': 1},
        ]
        
        for data in areas:
            AreaAcademica.objects.update_or_create(
                areaca_vcCodigo=data['areaca_vcCodigo'],
                defaults={
                    'areaca_vcNombre': data['areaca_vcNombre'],
                    'areaca_bActivo': data['areaca_bActivo']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(areas)} áreas académicas cargadas'))

    def seed_escuelas(self):
        """Poblar tabla de Escuelas"""
        self.stdout.write('Cargando Escuelas...')
        
        fisi = Facultad.objects.get(fac_vcCodigo='FISI')
        area_inf = AreaAcademica.objects.get(areaca_vcCodigo='INF')
        area_ing = AreaAcademica.objects.get(areaca_vcCodigo='ING')
        
        escuelas = [
            {
                'esc_vcCodigo': 'IS',
                'esc_vcNombre': 'Ingeniería de Sistemas',
                'esc_bActivo': 1,
                'fac_iCodigo': fisi,
                'areaca_iCodigo': area_inf
            },
            {
                'esc_vcCodigo': 'SW',
                'esc_vcNombre': 'Ingeniería de Software',
                'esc_bActivo': 1,
                'fac_iCodigo': fisi,
                'areaca_iCodigo': area_inf
            },
            {
                'esc_vcCodigo': 'CC',
                'esc_vcNombre': 'Ciencia de la Computación',
                'esc_bActivo': 1,
                'fac_iCodigo': fisi,
                'areaca_iCodigo': area_inf
            },
        ]
        
        for data in escuelas:
            Escuela.objects.update_or_create(
                esc_vcCodigo=data['esc_vcCodigo'],
                defaults={
                    'esc_vcNombre': data['esc_vcNombre'],
                    'esc_bActivo': data['esc_bActivo'],
                    'fac_iCodigo': data['fac_iCodigo'],
                    'areaca_iCodigo': data['areaca_iCodigo']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(escuelas)} escuelas cargadas'))

    def seed_dias(self):
        """Poblar tabla de Días"""
        self.stdout.write('Cargando Días...')
        
        dias = [
            {'dia_iNumero': 1, 'dia_vcNombre': 'Lunes'},
            {'dia_iNumero': 2, 'dia_vcNombre': 'Martes'},
            {'dia_iNumero': 3, 'dia_vcNombre': 'Miércoles'},
            {'dia_iNumero': 4, 'dia_vcNombre': 'Jueves'},
            {'dia_iNumero': 5, 'dia_vcNombre': 'Viernes'},
            {'dia_iNumero': 6, 'dia_vcNombre': 'Sábado'},
        ]
        
        for data in dias:
            Dia.objects.update_or_create(
                dia_iNumero=data['dia_iNumero'],
                defaults={'dia_vcNombre': data['dia_vcNombre']}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(dias)} días cargados'))

    def seed_semestres(self):
        """Poblar tabla de Semestres"""
        self.stdout.write('Cargando Semestres...')
        
        semestres = [
            {'sem_vcCodigo': '2024-I', 'sem_cActivo': 'N'},
            {'sem_vcCodigo': '2024-II', 'sem_cActivo': 'N'},
            {'sem_vcCodigo': '2025-I', 'sem_cActivo': 'S'},
            {'sem_vcCodigo': '2025-II', 'sem_cActivo': 'N'},
        ]
        
        for data in semestres:
            Semestre.objects.update_or_create(
                sem_vcCodigo=data['sem_vcCodigo'],
                defaults={'sem_cActivo': data['sem_cActivo']}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(semestres)} semestres cargados'))

    def seed_locales(self):
        """Poblar tabla de Locales"""
        self.stdout.write('Cargando Locales...')
        
        locales = [
            {'loc_vcCodigo': 'FISI', 'loc_vcNombre': 'Pabellón FISI'},
            {'loc_vcCodigo': 'FIM', 'loc_vcNombre': 'Pabellón FIM'},
            {'loc_vcCodigo': 'FIEE', 'loc_vcNombre': 'Pabellón FIEE'},
            {'loc_vcCodigo': 'LAB', 'loc_vcNombre': 'Laboratorios Centrales'},
        ]
        
        for data in locales:
            Local.objects.update_or_create(
                loc_vcCodigo=data['loc_vcCodigo'],
                defaults={'loc_vcNombre': data['loc_vcNombre']}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(locales)} locales cargados'))

    def seed_aulas(self):
        """Poblar tabla de Aulas"""
        self.stdout.write('Cargando Aulas...')
        
        local_fisi = Local.objects.get(loc_vcCodigo='FISI')
        local_lab = Local.objects.get(loc_vcCodigo='LAB')
        local_fim = Local.objects.get(loc_vcCodigo='FIM')
        
        aulas = [
            # Pabellón FISI - Primer Piso
            {'aul_vcCodigo': 'A-101', 'aul_iCapacidad': 40, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-102', 'aul_iCapacidad': 35, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-103', 'aul_iCapacidad': 40, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-104', 'aul_iCapacidad': 45, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-105', 'aul_iCapacidad': 38, 'loc_iCodigo': local_fisi},
            
            # Pabellón FISI - Segundo Piso
            {'aul_vcCodigo': 'A-201', 'aul_iCapacidad': 45, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-202', 'aul_iCapacidad': 40, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-203', 'aul_iCapacidad': 42, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-204', 'aul_iCapacidad': 40, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-205', 'aul_iCapacidad': 50, 'loc_iCodigo': local_fisi},
            
            # Pabellón FISI - Tercer Piso
            {'aul_vcCodigo': 'A-301', 'aul_iCapacidad': 50, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-302', 'aul_iCapacidad': 48, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-303', 'aul_iCapacidad': 45, 'loc_iCodigo': local_fisi},
            {'aul_vcCodigo': 'A-304', 'aul_iCapacidad': 42, 'loc_iCodigo': local_fisi},
            
            # Laboratorios
            {'aul_vcCodigo': 'LAB-1', 'aul_iCapacidad': 30, 'loc_iCodigo': local_lab},
            {'aul_vcCodigo': 'LAB-2', 'aul_iCapacidad': 30, 'loc_iCodigo': local_lab},
            {'aul_vcCodigo': 'LAB-3', 'aul_iCapacidad': 25, 'loc_iCodigo': local_lab},
            {'aul_vcCodigo': 'LAB-4', 'aul_iCapacidad': 28, 'loc_iCodigo': local_lab},
            {'aul_vcCodigo': 'LAB-5', 'aul_iCapacidad': 32, 'loc_iCodigo': local_lab},
            {'aul_vcCodigo': 'LAB-6', 'aul_iCapacidad': 30, 'loc_iCodigo': local_lab},
            
            # Aulas FIM
            {'aul_vcCodigo': 'B-101', 'aul_iCapacidad': 35, 'loc_iCodigo': local_fim},
            {'aul_vcCodigo': 'B-102', 'aul_iCapacidad': 40, 'loc_iCodigo': local_fim},
            {'aul_vcCodigo': 'B-201', 'aul_iCapacidad': 38, 'loc_iCodigo': local_fim},
        ]
        
        for data in aulas:
            Aula.objects.update_or_create(
                aul_vcCodigo=data['aul_vcCodigo'],
                defaults={
                    'aul_iCapacidad': data['aul_iCapacidad'],
                    'loc_iCodigo': data['loc_iCodigo']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(aulas)} aulas cargadas'))

    def seed_tipos_curso(self):
        """Poblar tabla de Tipos de Curso"""
        self.stdout.write('Cargando Tipos de Curso...')
        
        tipos = [
            {'curtip_vcNombre': 'Obligatorio', 'curtip_bActivo': 1},
            {'curtip_vcNombre': 'Electivo', 'curtip_bActivo': 1},
            {'curtip_vcNombre': 'Humanidades', 'curtip_bActivo': 1},
            {'curtip_vcNombre': 'Ciencias Básicas', 'curtip_bActivo': 1},
        ]
        
        for data in tipos:
            CursoTipo.objects.update_or_create(
                curtip_vcNombre=data['curtip_vcNombre'],
                defaults={'curtip_bActivo': data['curtip_bActivo']}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(tipos)} tipos de curso cargados'))

    def seed_planes_estudio(self):
        """Poblar tabla de Planes de Estudio"""
        self.stdout.write('Cargando Planes de Estudio...')
        
        escuela_is = Escuela.objects.get(esc_vcCodigo='IS')
        escuela_sw = Escuela.objects.get(esc_vcCodigo='SW')
        escuela_cc = Escuela.objects.get(esc_vcCodigo='CC')
        
        planes = [
            {
                'plaest_vcCodigo': '2018-IS',
                'plaest_vcRR': 'RR-001-2018',
                'plaest_iCreditos': 210,
                'plaest_bActivo': 1,
                'esc_iCodigo': escuela_is
            },
            {
                'plaest_vcCodigo': '2020-IS',
                'plaest_vcRR': 'RR-015-2020',
                'plaest_iCreditos': 215,
                'plaest_bActivo': 1,
                'esc_iCodigo': escuela_is
            },
            {
                'plaest_vcCodigo': '2020-SW',
                'plaest_vcRR': 'RR-016-2020',
                'plaest_iCreditos': 210,
                'plaest_bActivo': 1,
                'esc_iCodigo': escuela_sw
            },
            {
                'plaest_vcCodigo': '2020-CC',
                'plaest_vcRR': 'RR-017-2020',
                'plaest_iCreditos': 205,
                'plaest_bActivo': 1,
                'esc_iCodigo': escuela_cc
            },
        ]
        
        for data in planes:
            PlanEstudio.objects.update_or_create(
                plaest_vcCodigo=data['plaest_vcCodigo'],
                defaults={
                    'plaest_vcRR': data['plaest_vcRR'],
                    'plaest_iCreditos': data['plaest_iCreditos'],
                    'plaest_bActivo': data['plaest_bActivo'],
                    'esc_iCodigo': data['esc_iCodigo']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(planes)} planes de estudio cargados'))

    def seed_cursos(self):
        """Poblar tabla de Cursos"""
        self.stdout.write('Cargando Cursos...')
        
        plan_is = PlanEstudio.objects.get(plaest_vcCodigo='2020-IS')
        plan_sw = PlanEstudio.objects.get(plaest_vcCodigo='2020-SW')
        tipo_obligatorio = CursoTipo.objects.get(curtip_vcNombre='Obligatorio')
        tipo_electivo = CursoTipo.objects.get(curtip_vcNombre='Electivo')
        tipo_basico = CursoTipo.objects.get(curtip_vcNombre='Ciencias Básicas')
        area_inf = AreaAcademica.objects.get(areaca_vcCodigo='INF')
        area_mat = AreaAcademica.objects.get(areaca_vcCodigo='MAT')
        area_fis = AreaAcademica.objects.get(areaca_vcCodigo='FIS')
        area_hum = AreaAcademica.objects.get(areaca_vcCodigo='HUM')
        
        cursos = [
            # Primer Semestre
            {'cur_vcCodigo': '1I101', 'cur_vcNombre': 'Introducción a la Informática', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 0.0, 'cur_iSemestre': 1, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '1M101', 'cur_vcNombre': 'Matemática I', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 0.0, 'cur_iSemestre': 1, 'curtip_iCodigo': tipo_basico, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_mat},
            {'cur_vcCodigo': '1F101', 'cur_vcNombre': 'Física I', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 0.0, 'cur_iSemestre': 1, 'curtip_iCodigo': tipo_basico, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_fis},
            {'cur_vcCodigo': '1H101', 'cur_vcNombre': 'Comunicación I', 'cur_fCreditos': 3.0, 'cur_fCreditosRequisito': 0.0, 'cur_iSemestre': 1, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_hum},
            
            # Segundo Semestre
            {'cur_vcCodigo': '1I102', 'cur_vcNombre': 'Algoritmos y Estructura de Datos I', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 4.0, 'cur_iSemestre': 2, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '1M102', 'cur_vcNombre': 'Matemática II', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 5.0, 'cur_iSemestre': 2, 'curtip_iCodigo': tipo_basico, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_mat},
            {'cur_vcCodigo': '1F102', 'cur_vcNombre': 'Física II', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 4.5, 'cur_iSemestre': 2, 'curtip_iCodigo': tipo_basico, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_fis},
            
            # Tercer Semestre
            {'cur_vcCodigo': '2I201', 'cur_vcNombre': 'Base de Datos I', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 14.0, 'cur_iSemestre': 3, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '2I203', 'cur_vcNombre': 'Programación Orientada a Objetos', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 14.0, 'cur_iSemestre': 3, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '2M201', 'cur_vcNombre': 'Matemática Discreta', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 10.0, 'cur_iSemestre': 3, 'curtip_iCodigo': tipo_basico, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_mat},
            
            # Cuarto Semestre
            {'cur_vcCodigo': '2I202', 'cur_vcNombre': 'Ingeniería de Software I', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 20.0, 'cur_iSemestre': 4, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '2I204', 'cur_vcNombre': 'Base de Datos II', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 24.5, 'cur_iSemestre': 4, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '2I205', 'cur_vcNombre': 'Arquitectura de Computadoras', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 20.0, 'cur_iSemestre': 4, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            
            # Quinto Semestre
            {'cur_vcCodigo': '3I301', 'cur_vcNombre': 'Desarrollo Web', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 30.0, 'cur_iSemestre': 5, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '3I302', 'cur_vcNombre': 'Redes y Comunicaciones', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 30.0, 'cur_iSemestre': 5, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '3I303', 'cur_vcNombre': 'Sistemas Operativos', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 30.0, 'cur_iSemestre': 5, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            
            # Sexto Semestre
            {'cur_vcCodigo': '3I304', 'cur_vcNombre': 'Inteligencia Artificial', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 40.0, 'cur_iSemestre': 6, 'curtip_iCodigo': tipo_electivo, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '3I305', 'cur_vcNombre': 'Seguridad Informática', 'cur_fCreditos': 4.0, 'cur_fCreditosRequisito': 40.0, 'cur_iSemestre': 6, 'curtip_iCodigo': tipo_electivo, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '3I306', 'cur_vcNombre': 'Computación en la Nube', 'cur_fCreditos': 3.5, 'cur_fCreditosRequisito': 40.0, 'cur_iSemestre': 6, 'curtip_iCodigo': tipo_electivo, 'plaest_iCodigo': plan_is, 'curare_iCodigo': area_inf},
            
            # Cursos para Software
            {'cur_vcCodigo': '1SW101', 'cur_vcNombre': 'Fundamentos de Programación', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 0.0, 'cur_iSemestre': 1, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_sw, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '2SW201', 'cur_vcNombre': 'Desarrollo de Software', 'cur_fCreditos': 5.0, 'cur_fCreditosRequisito': 15.0, 'cur_iSemestre': 3, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_sw, 'curare_iCodigo': area_inf},
            {'cur_vcCodigo': '3SW301', 'cur_vcNombre': 'Arquitectura de Software', 'cur_fCreditos': 4.5, 'cur_fCreditosRequisito': 35.0, 'cur_iSemestre': 5, 'curtip_iCodigo': tipo_obligatorio, 'plaest_iCodigo': plan_sw, 'curare_iCodigo': area_inf},
        ]
        
        for data in cursos:
            Curso.objects.update_or_create(
                cur_vcCodigo=data['cur_vcCodigo'],
                plaest_iCodigo=data['plaest_iCodigo'],
                defaults={
                    'cur_vcNombre': data['cur_vcNombre'],
                    'cur_fCreditos': data['cur_fCreditos'],
                    'cur_fCreditosRequisito': data['cur_fCreditosRequisito'],
                    'cur_iSemestre': data['cur_iSemestre'],
                    'curtip_iCodigo': data['curtip_iCodigo'],
                    'curare_iCodigo': data['curare_iCodigo']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(cursos)} cursos cargados'))

    def seed_tipos_dictado(self):
        """Poblar tabla de Tipos de Dictado"""
        self.stdout.write('Cargando Tipos de Dictado...')
        
        tipos = [
            {'curtipdi_vcNombre': 'Teoría'},
            {'curtipdi_vcNombre': 'Práctica'},
            {'curtipdi_vcNombre': 'Laboratorio'},
            {'curtipdi_vcNombre': 'Seminario'},
        ]
        
        for data in tipos:
            CursoTipoDictado.objects.update_or_create(
                curtip_vcNombre=data['curtipdi_vcNombre'],
                defaults={}
            )
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {len(tipos)} tipos de dictado cargados'))

    def seed_horas_dictado(self):
        """Poblar tabla de Horas de Dictado"""
        self.stdout.write('Cargando Horas de Dictado...')
        
        # Obtener todos los cursos y tipos de dictado
        cursos = Curso.objects.all()[:3]  # Solo algunos cursos de ejemplo
        tipo_teoria = CursoTipoDictado.objects.get(curtip_vcNombre='Teoría')
        tipo_practica = CursoTipoDictado.objects.get(curtip_vcNombre='Práctica')
        tipo_lab = CursoTipoDictado.objects.get(curtip_vcNombre='Laboratorio')
        
        for curso in cursos:
            # Teoría
            CursoHorasDictado.objects.update_or_create(
                cur_iCodigo=curso,
                curtip_iCodigo=tipo_teoria,
                defaults={'curhor_iHoras': 3}
            )
            # Práctica
            CursoHorasDictado.objects.update_or_create(
                cur_iCodigo=curso,
                curtip_iCodigo=tipo_practica,
                defaults={'curhor_iHoras': 2}
            )
        
        self.stdout.write(self.style.SUCCESS('  ✓ Horas de dictado cargadas'))

    def seed_grupos(self):
        """Poblar tabla de Grupos"""
        self.stdout.write('Cargando Grupos...')
        
        semestre_activo = Semestre.objects.get(sem_cActivo='S')
        cursos = Curso.objects.filter(plaest_iCodigo__plaest_vcCodigo='2020-IS')[:10]
        
        contador = 0
        for curso in cursos:
            # Crear 2-3 grupos por curso
            num_grupos = 2 if curso.cur_iSemestre and curso.cur_iSemestre <= 3 else 3
            for i in range(1, num_grupos + 1):
                Grupo.objects.update_or_create(
                    sem_iCodigo=semestre_activo,
                    cur_iCodigo=curso,
                    gru_iNumero=i,
                    defaults={'gru_iTope': 35 + (i * 5)}
                )
                contador += 1
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {contador} grupos cargados'))

    def seed_grupo_horarios(self):
        """Poblar tabla de Horarios de Grupos"""
        self.stdout.write('Cargando Horarios de Grupos...')
        
        grupos = Grupo.objects.all()[:15]  # Primeros 15 grupos
        aulas = list(Aula.objects.all()[:10])
        dias = list(Dia.objects.all())
        tipo_teoria = CursoTipoDictado.objects.get(curtip_vcNombre='Teoría')
        tipo_practica = CursoTipoDictado.objects.get(curtip_vcNombre='Práctica')
        
        horarios = [
            (time(8, 0), time(10, 0)),
            (time(10, 0), time(12, 0)),
            (time(12, 0), time(14, 0)),
            (time(14, 0), time(16, 0)),
            (time(16, 0), time(18, 0)),
            (time(18, 0), time(20, 0)),
        ]
        
        contador = 0
        for idx, grupo in enumerate(grupos):
            # Teoría (2 días a la semana)
            dia_teoria = dias[idx % len(dias)]
            hora_teoria = horarios[idx % len(horarios)]
            aula_teoria = aulas[idx % len(aulas)]
            
            GrupoHorario.objects.update_or_create(
                gru_iCodigo=grupo,
                dia_iCodigo=dia_teoria,
                curtip_iCodigo=tipo_teoria,
                defaults={
                    'aul_iCodigo': aula_teoria,
                    'gruhor_tHoraInicio': hora_teoria[0],
                    'gruhor_tHoraFinal': hora_teoria[1]
                }
            )
            contador += 1
            
            # Práctica (1 día a la semana)
            if idx + 2 < len(dias):
                dia_practica = dias[(idx + 2) % len(dias)]
                hora_practica = horarios[(idx + 1) % len(horarios)]
                aula_practica = aulas[(idx + 1) % len(aulas)]
                
                try:
                    GrupoHorario.objects.update_or_create(
                        gru_iCodigo=grupo,
                        dia_iCodigo=dia_practica,
                        curtip_iCodigo=tipo_practica,
                        defaults={
                            'aul_iCodigo': aula_practica,
                            'gruhor_tHoraInicio': hora_practica[0],
                            'gruhor_tHoraFinal': hora_practica[1]
                        }
                    )
                    contador += 1
                except:
                    pass  # Si hay conflicto de horario, continuar
        
        self.stdout.write(self.style.SUCCESS(f'  ✓ {contador} horarios cargados'))
