# Arquitectura de VPC en AWS

## Descripción del Proyecto

Este proyecto implementa una arquitectura de red fundamentada en Amazon Web Services (AWS), demostrando el despliegue de una Nube Privada Virtual (VPC) completamente funcional con recursos de red y computación. La arquitectura incluye una subred pública con acceso a Internet, un servidor web Apache ejecutándose en una instancia EC2, y configuraciones de seguridad de red adecuadas para garantizar la funcionalidad y la protección de los recursos en la nube.

---

## Componentes de la Arquitectura

### 1. Creación de la Nube Privada Virtual (VPC)

Se implementó una VPC personalizada que actúa como un entorno de red aislado dentro de AWS. Esta VPC aloja todos los demás componentes de la arquitectura y proporciona control total sobre el espacio de direcciones IP.

![Creación VPC](screenshots/1.%20Creación%20VPC.PNG)

**Detalles técnicos:**
- Se configuró el espacio de direcciones IP mediante CIDR blocks personalizados
- La VPC proporciona aislamiento de red y seguridad en la capa de infraestructura

---

### 2. Creación de la Subred Pública

La subred pública se configuró dentro de la VPC para alojar recursos que requieren conectividad directa con Internet. Esta subred permite que las instancias EC2 reciban direcciones IP públicas y establezcan comunicaciones bidireccionales con la red global.

![Creación Subnet Pública](screenshots/2.%20Creación%20Subnet%20Pública.PNG)

**Características implementadas:**
- Subred con asignación automática de direcciones IP públicas habilitada
- Configuración de zona de disponibilidad específica para garantizar redundancia

---

### 3. Internet Gateway

El Internet Gateway (IGW) es un componente esencial que permite la comunicación entre la VPC e Internet. Sin este componente, los recursos dentro de la VPC no podrían acceder a Internet ni ser accesibles desde el exterior.

![Internet Gateway](screenshots/3.%20Internet%20Gateway.PNG)

**Configuración aplicada:**
- Creación y asociación del IGW a la VPC
- Activación de la puerta de enlace para permitir tráfico bidireccional

---

### 4. Tabla de Enrutamiento

La tabla de enrutamiento dirige el tráfico de red en la VPC, determinando hacia dónde se envían los paquetes según sus direcciones de destino. Se configuró una ruta por defecto dirigida al Internet Gateway para permitir que el tráfico destinado a Internet salga hacia el exterior.

![Creación tabla de enrutamiento](screenshots/4.%20Creación%20tabla%20de%20enrutamiento.PNG)

**Reglas de enrutamiento configuradas:**
- Ruta local: Tráfico dentro de la VPC se distribuye internamente
- Ruta hacia Internet: Todo tráfico destinado a Internet (0.0.0.0/0) se dirige al Internet Gateway

---

### 5. Grupo de Seguridad

El grupo de seguridad actúa como un firewall virtual que controla el tráfico de entrada y salida de las instancias EC2. Se configuraron reglas específicas para permitir la conectividad HTTP, HTTPS y SSH.

![Creación grupo de seguridad](screenshots/5.%20Creación%20grupo%20de%20seguridad.PNG)

**Reglas de entrada configuradas:**

- **HTTP (Puerto 80):** Permite acceso desde cualquier dirección IP (0.0.0.0/0) para visualizar la página web del servidor
- **HTTPS (Puerto 443):** Habilitado para comunicaciones seguras
- **SSH (Puerto 22):** Permite conexión remota segura desde cualquier dirección IP

Estas reglas garantizan que:
- Los usuarios pueden acceder al servidor web a través de Internet
- Los administradores pueden conectarse remotamente al servidor mediante SSH
- La instancia puede recibir tráfico de múltiples fuentes

---

### 6. Mapa de Recursos

El mapa de recursos de AWS proporciona una representación visual de cómo todos los componentes de la arquitectura están interconectados y funcionan conjuntamente.

![Mapa de recursos](screenshots/6.%20Mapa%20de%20recursos.PNG)

**Conexiones demostradas en el mapa:**
- La subred pública está correctamente asociada con la tabla de enrutamiento
- El Internet Gateway está conectado a la VPC y vinculado a la tabla de enrutamiento
- La instancia EC2 reside en la subred pública
- El flujo de tráfico entre Internet, el IGW, la tabla de enrutamiento y la subred está correctamente configurado

---

### 7. Par de Llaves para la Instancia EC2

Para garantizar acceso seguro a la instancia EC2 mediante SSH, se generó un par de llaves criptográficas. La llave privada se descarga y se utiliza para autenticación segura sin contraseña.

![Par de llaves](screenshots/7.%20Par%20de%20llaves.PNG)

**Procedimiento de seguridad implementado:**
- Generación de par de llaves RSA de 2048 bits
- Descarga segura de la llave privada (.pem)
- Configuración de permisos restrictivos en la llave privada (chmod 400)

---

### 8. Detalles de la Instancia EC2

Se desplegó una instancia EC2 en la subred pública configurada con Apache como servidor web. La instancia está equipada con una dirección IP pública que permite tanto acceso HTTP como SSH.

![Detalles instancia Ec2](screenshots/8.%20Detalles%20instancia%20Ec2.PNG)

**Especificaciones técnicas:**
- Tipo de instancia: t2.micro (elegible para capa gratuita de AWS)
- Sistema operativo: Amazon Linux 2 o similar
- Software instalado: Apache HTTP Server (httpd)
- Dirección IP pública: Asignada automáticamente
- Seguridad: Asociada con el grupo de seguridad configurado

---

### 9. Servidor Web Funcional

Se validó que el servidor web Apache está operativo y sirviendo contenido HTML correctamente. La página web es accesible desde Internet a través de la dirección IP pública de la instancia.

![Página web](screenshots/9.%20Página%20web.PNG)

**Validación realizada:**
- Acceso HTTP exitoso al servidor en el puerto 80
- Visualización correcta de la página HTML servida por Apache
- Confirmación de conectividad bidireccional a través del Internet Gateway

---

### 10. Conexión Segura por SSH

Se estableció una conexión SSH exitosa a la instancia EC2 utilizando la llave privada generada. Esta conexión permite la administración remota segura del servidor.

![Conexión por putty](screenshots/10.%20Conexión%20por%20putty.PNG)

**Parámetros de conexión utilizados:**
- Protocolo: SSH (Secure Shell)
- Autenticación: Basada en clave privada
- Puerto: 22 (SSH estándar)
- Cliente utilizado: PuTTY u otro cliente SSH compatible
- Usuario: ec2-user (usuario por defecto en Amazon Linux)

---

## Resumen de la Arquitectura

La arquitectura implementada demuestra los principios fundamentales de diseño de redes en la nube:

1. **Aislamiento de red:** La VPC proporciona un entorno de red privado y controlado
2. **Conectividad:** El Internet Gateway habilita la comunicación con Internet
3. **Enrutamiento inteligente:** La tabla de enrutamiento dirige el tráfico eficientemente
4. **Seguridad en capas:** El grupo de seguridad controla el acceso a nivel de firewall
5. **Acceso seguro:** La autenticación por llave SSH garantiza seguridad administrativa
6. **Disponibilidad:** Los recursos están distribuidos en zonas de disponibilidad

---

## Conclusión

Este proyecto valida el despliegue exitoso de una infraestructura de nube profesional en AWS, integrando conceptos de red, seguridad y computación en la nube. La arquitectura es escalable, segura y puede servir como base para proyectos más complejos que requieran subredes privadas adicionales, bases de datos, balanceadores de carga o servicios administrados.
