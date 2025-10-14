import requests
import sys

OLLAMA_URL = "http://localhost:11434/v1/chat/completions"
MODEL_NAME = "qwen2.5-coder:3b"

SYSTEM_PROMPT = (
    "ты программист с 10 летним стажем в bash, python, C, C++, Ruby, Go. "
    "помогай пользователю работать с командной строкой linux. отвечай просто и понятно."
)

def query_ollama(system_prompt, user_input, max_tokens=512):
    data = {
        "model": MODEL_NAME,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_input}
        ],
        "max_tokens": max_tokens
    }
    try:
        response = requests.post(OLLAMA_URL, json=data)
        response.raise_for_status()
        result = response.json()
        return result["choices"][0]["message"]["content"].strip()
    except Exception as e:
        return f"Ошибка общения с Ollama: {e}"

def main():
    print(f"Запуск snh с моделью {MODEL_NAME}. При выходе используйте Ctrl+C.")
    print("Системный промт:")
    print(SYSTEM_PROMPT)
    print()

    try:
        while True:
            user_input = input("Пользователь: ").strip()
            if not user_input:
                continue

            answer = query_ollama(SYSTEM_PROMPT, user_input)
            print(f"AI: {answer}")

    except KeyboardInterrupt:
        print("\nВыход из программы. До свидания!")
        sys.exit(0)

if __name__ == "__main__":
    main()

