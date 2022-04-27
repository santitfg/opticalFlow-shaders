# opticalFlow-shaders
Procesos para un trabajo practico de la materia Entornos Sensoriales I (2021) de la UNTREF

en cada carpeta hay un sketch de processing con optical flow desde una camara y un shader acosiado a un tipo de setup diferente
a ecepcion de la carpeta op_flow_matrix que solamente tiene una visualizacion del flujo optico representado en una grilla de 10 * 10 con vectores indicando las variaciones

el primer sahder (el complex) genera un latice de mosaicos que invierten el color y muestran un feedback de la imagen 

mientras que los simplificados utilizan una suma de todo el optical flow para generar un efecto similar, superponiendo la iomagen en tiempo real (ya con un efecto de hsv para la simplificada) con un feedback invertido en color
a su vez el simplificado con osc envia un pequeño analicis via OSC para utilizar en pd


op_flow_complex_shader

![Sin título-1](https://user-images.githubusercontent.com/88756407/165586649-77f24b89-53c8-4c28-8d2d-e2d4f96643b8.jpg)


op_flow_simplificada_shader
![opticap flow simple hsv](https://user-images.githubusercontent.com/88756407/165588244-6beb9b02-d911-4768-ae7b-a54847f5d271.jpg)

op_flow_simplificada_shader_osc
![opticap flow simple](https://user-images.githubusercontent.com/88756407/165588362-a8849c4a-1e64-4cec-8984-ea72064024a1.jpg)

op_flow_matrix

![matrix op flow](https://user-images.githubusercontent.com/88756407/165588224-dc86d537-6a50-4afb-a9a7-a85c89e21e8a.jpg)

