# Generated by Django 4.2.6 on 2023-11-13 18:13

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('escuela', '0002_alter_curso_curare_icodigo_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cursotipo',
            name='curtip_iCodigo',
            field=models.AutoField(editable=False, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='planestudio',
            name='plaest_dVigencia',
            field=models.DateTimeField(blank=True, default=datetime.datetime.now, verbose_name='Vigencia'),
        ),
    ]