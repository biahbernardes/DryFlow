// Incluindo a biblioteca para o sensor DHT11 

#include "DHT.h" 

 

// Definição do tipo de sensor e do pino utilizado 

#define TIPO_SENSOR DHT11 

const int PINO_SENSOR_DHT11 = A0;  // Pino conectado ao sensor DHT11 

 

// Inicializa o objeto DHT 

DHT sensorDHT(PINO_SENSOR_DHT11, TIPO_SENSOR); 

 

// Função de inicialização 

void setup() { 

  Serial.begin(9600);      // Inicializa a comunicação serial a 9600 bps 

  sensorDHT.begin();       // Inicializa o sensor DHT11 

} 

 

// Função principal de execução contínua 

void loop() { 

  // Lê a umidade e a temperatura do sensor 

  float umidade = sensorDHT.readHumidity(); 

 // float temperatura = sensorDHT.readTemperature(); 

 

  // Verifica se houve erro na leitura 

  if (isnan(umidade)) { 

    Serial.println("Erro ao ler os dados do sensor"); 

  } else { 

    // Exibe os valores lidos no monitor serial 

    Serial.print(umidade); 

    Serial.println(";"); 

    //Serial.println(temperatura); 

  } 

 

  // Aguarda 1 segundo antes da próxima leitura 

  delay(1000); 

} 

 