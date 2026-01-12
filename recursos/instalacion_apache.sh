#!/bin/bash
# 1. Actualizar los paquetes del sistema
yum update -y

# 2. Instalar el servidor web Apache (httpd)
yum install -y httpd

# 3. Iniciar el servicio web
systemctl start httpd

# 4. Configurar para que inicie automáticamente si se reinicia la instancia
systemctl enable httpd

# 5. Crear el archivo index.html con tu mensaje
echo "<html>
<head><title>Prueba de Conectividad</title></head>
<body>
    <div style='text-align: center; margin-top: 50px;'>
        <h1>¡Éxito!</h1>
        <h2>La VPC y la Instancia funcionan bien.</h2>
        <p>Este mensaje confirma que tienes salida a internet y el servidor web está activo.</p>
    </div>
</body>
</html>" > /var/www/html/index.html