// kernel.c
void main() {
    const char* str = "Hello from kernel!";
    char* video = (char*)0xb8000;
    for (int i = 0; str[i] != '\0'; i++) {
        video[i * 2] = str[i];
        video[i * 2 + 1] = 0x07;
    }
    while (1); // бесконечный цикл
}
