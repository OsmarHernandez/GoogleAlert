# GoogleAlert
### Taller Vertical LAE 2019 - Tec Campus Chihuahua

## Introducción
Google Alert es una aplicación que permite conocer algún tipo de atentado en una ubicación geográfica para sus usuarios así como el de señalar cualquier tipo de incidente. 

## Aplicación Movil
De momento solo se cuenta con un demo de la aplicación para dispositivos iOS la cual permite tener una idea sobre su funcionamiento. Dentro de las tecnologías utilizadas para el desarrollo de esta se utilizaron:

* Xcode para el desarrollo de la app.
* Google Maps iOS SDK para el uso de los mapas de Google.
* Places API para la búsqueda de lugares en el mapa.

La aplicación no permite en este momento manejo de usuarios ni cuenta con una base de datos para guardar información pero para lograr un mejor funcionamiento se recomienda usar las siguientes tecnologías de Google:

* Firebase para la autenticación de usuarios.
* Realtime Database para guardar y mostrar los puntos con incidente en los mapas en tiempo real.
* Cloud Firestore para crear un chat entre usuarios en caso de que así se desee.
* Cloud Vision para procesar contenido digital y de esta manera proteger la identidad de los usuarios.

El tiempo de desarrollo estimado para las funcionalidades previamente mencionadas es de aproximadamente 5 días en total para la implementación de cada uno de los módulos.

## Funcionamiento
La aplicación cuenta con tres pantallas:

* MainViewController: Muestra un menu para seleccionar un tipo de ayuda según el atentado.
* LevelEmergencyViewController: Muestra un menu para seleccionar el nivel de emergencia (poco urgente, medio urgente, urgente)
* MapViewController: Muestra la posición real del usuario y el lugar donde occurió el incidente.

Al abrir la aplicación, se muestra un menu donde el usuario selecciona el tipo de ayuda según corresponda a cierto tipo de incidente. Los tipos de ayuda son: policia, bomberos, protección civil y ambulancia. Seguido de esto, el usuario selecciona el nivel de emergencia dependiendo de la gravedad de la situacion, entre los cuales podrá seleccionar poco urgente, medio urgente o urgente. Para finalizar, en la tercera pantalla se muestra un mapa con la posición real del usuario. Es aquí donde el usuario busca en un campo de texto la ubicación donde ocurrió algun tipo de incidente. Al momento de marcar la ubicación un circulo con un radio de 250 mts se pinta en el mapa, alertando a usuarios cercanos al incidente.

**Nota: Para hacer uso de esta aplicación es necesario tener una llave otorgada por el API de Google Places e inicializarla en el AppDelegate. Esta llave se puede configurar en el siguiente enlace: [Places API](https://developers.google.com/places/web-service/get-api-key)**
