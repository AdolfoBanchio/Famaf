// Generador de señal de reloj síncrona.
volatile const unsigned int CLOCK_PIN = 8;
// El periodo define la frecuencia: f = 1 / (PERIODO_MS * 1e-3).
volatile const unsigned int PERIODO_MS = 800;

void setup() {
  pinMode(CLOCK_PIN, OUTPUT);
}

void loop() {
  digitalWrite(CLOCK_PIN, HIGH);
  delay(PERIODO_MS / 2);
  digitalWrite(CLOCK_PIN, LOW);
  delay(PERIODO_MS / 2);
}
