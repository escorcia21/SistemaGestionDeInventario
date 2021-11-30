import locale

from fpdf import FPDF
locale.setlocale(locale.LC_ALL, 'en_US.utf8')

def Pesoinador(Peso):
    """
    Descripcion:
    Convierte un valor flotante a string.

    Entradas:
    peso (str) --- 0,000,000.000 
    """
    
    Peso = locale.currency(Peso, grouping=True)
    return str(Peso)

def informe(Ventas,Gastos,NumeroVentas,Mes,Ano):
    """
    Descripcion:
    Convierte un valor flotante a string.

    Entradas:
    Ventas (str) --- Ventas en el mes 
    Gastos (str) --- gastos en el mes 
    NumeroVentas (str) --- numero de ventas en el mes
    Mes (str) --- mes 
    Ano (str) --- año

    Salida: 
    Genera un informe en formato pdf que se guarda en la carpeta Documentos bajo el nombre de factura.pdf
    """
    NumeroVentas = str(NumeroVentas)
    Ganancias =int(Ventas)-int(Gastos)
    Signo = ""

    if (Ventas < Gastos): Signo = "-"
    Ganancias = Pesoinador(abs(Ganancias))
    Ventas = Pesoinador(Ventas)
    Gastos = Pesoinador(Gastos)


    Fecha = f"{Mes}/{Ano}"
    pdf = FPDF()
    pdf.add_page(orientation='P')
    pdf.set_font('arial', 'B', 13.0)
    pdf.set_xy(105.0, 23.5)
    pdf.cell(ln=0, h=22.0, align='C', w=75.0, txt='REPORTE', border=0)
    pdf.set_line_width(0.0)
    pdf.rect(15.0, 15.0, 170.0, 245.0)
    pdf.set_line_width(0.0)
    pdf.line(100.0, 15.0, 100.0, 57.0)
    pdf.set_font('arial', 'B', 16.0)
    pdf.set_xy(17.0, 29.5)
    pdf.cell(ln=0, h=10.0, align='L', w=50.0, txt='ESPECIALIDAD ELECTRICA', border=0)
    pdf.set_font('arial', 'B', 16.0)
    pdf.set_xy(17.0, 35.5)
    pdf.cell(ln=0, h=10.0, align='L', w=50.0, txt='S.A.S.', border=0)
    pdf.set_font('arial', '', 12.0)
    pdf.set_xy(125.0, 37.0)
    pdf.cell(ln=0, h=7.0, align='L', w=60.0, txt='Fecha:', border=0)
    pdf.set_xy(143.0, 37.0)
    pdf.cell(ln=0, h=7.0, align='L', w=40.0, txt=Fecha, border=0)
    pdf.set_line_width(0.0)
    pdf.line(15.0, 57.0, 185.0, 57.0)

    pdf.set_font('arial', 'B', 25.0)
    pdf.set_xy(50.0, 64.0)
    pdf.cell(ln=0, h=6.0, align='L', w=13.0, txt='REPORTE MENSUAL', border=0)
    '''pdf.set_xy(35.0, 59.0)
    pdf.cell(ln=0, h=6.0, align='L', w=140.0, txt='Mariano Reingart', border=0)
    pdf.set_xy(17.0, 64.0)
    pdf.cell(ln=0, h=6.0, align='L', w=18.0, txt='Empleado:', border=0)
    pdf.set_xy(35.0, 64.0)
    pdf.cell(ln=0, h=6.0, align='L', w=125.0, txt='Siempreviva 12345', border=0)
    pdf.set_xy(17.0, 69.0)
    pdf.cell(ln=0, h=6.0, align='L', w=18.0, txt='Tel\xe9fono:', border=0)
    pdf.set_xy(35.0, 69.0)
    pdf.cell(ln=0, h=6.0, align='L', w=80.0, txt='+1-5555-5555', border=0)'''

    pdf.set_line_width(0.0)
    pdf.line(15.0, 77.0, 185.0, 77.0)

    pdf.set_font('arial', 'B', 12.0)
    pdf.set_xy(17.0, 80.0)
    pdf.cell(ln=0, h=5.0, align='L', w=15.0, txt='Total de ganancias ($):', border=0)

    pdf.set_font('arial', '', 12.0)
    pdf.set_xy(115.0, 80.0)
    pdf.cell(ln=0, h=5.0, align='L', w=20.0, txt=f"{Signo}{Ganancias}", border=0)


    pdf.set_line_width(0.0)
    pdf.line(15.0, 88.0, 185.0, 88.0)

    pdf.set_font('arial', 'B', 12.0)
    pdf.set_xy(17.0, 91.0)
    pdf.cell(ln=0, h=5.0, align='L', w=15.0, txt='Total de ventas ($):', border=0)

    pdf.set_font('arial', '', 12.0)
    pdf.set_xy(115.0, 91.0)
    pdf.cell(ln=0, h=5.0, align='L', w=20.0, txt=Ventas, border=0)


    pdf.set_line_width(0.0)
    pdf.line(15.0, 99, 185.0, 99)

    pdf.set_font('arial', 'B', 12.0)
    pdf.set_xy(17.0, 102.0)
    pdf.cell(ln=0, h=5.0, align='L', w=15.0, txt='Total de gastos ($):', border=0)

    pdf.set_font('arial', '', 12.0)
    pdf.set_xy(115.0, 102.0)
    pdf.cell(ln=0, h=5.0, align='L', w=20.0, txt=Gastos, border=0)

    pdf.set_line_width(0.0)
    pdf.line(15.0, 110, 185.0, 110)

    pdf.set_font('arial', 'B', 12.0)
    pdf.set_xy(17.0, 113.0)
    pdf.cell(ln=0, h=5.0, align='L', w=15.0, txt='Numero de ventas:', border=0)

    pdf.set_font('arial', '', 12.0)
    pdf.set_xy(115.0, 113.0)
    pdf.cell(ln=0, h=5.0, align='L', w=20.0, txt=NumeroVentas, border=0)

    pdf.set_line_width(0.0)
    pdf.line(15.0, 121, 185.0, 121)

    try:
        pdf.output('D:/Documents/factura.pdf', 'F')
    except Exception:
        pdf.output('D:/Documentos/factura.pdf', 'F')

