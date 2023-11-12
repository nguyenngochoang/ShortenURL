# Shortener Service

ShortenURL is a simple URL shortening service built using Ruby on Rails.

## Features

- **URL Shortening:** Shorten long URLs into more manageable shortened versions.
- **Custom Short URLs:** Ability to create custom aliases for URLs.
- **Expiration:** Set expiration dates for shortened URLs.

## Installation

1. **Clone the repository:**
  ```bash
  git clone https://github.com/nguyenngochoang/ShortenURL.git
  ```

2. **Navigate to the project directory:**
  ```bash
  cd ShortenURL
  ```

3. **Install dependencies:**
  ```bash
  bundle install
  ```

4. **Set up the database:**
  ```bash
  rails db:create and rails db:migrate
  ```

5. **Start the server:**
  ```bash
  rails server -p 3003
  ```

## Usage

1. **Access the application:**
  - Open your browser and go to `http://localhost:3003` to access the app.

2. **Shorten a URL:**
  - First, you will need to create an account using your email, [please go to this site](https://shortener-service-api.onrender.com/)
  - To shorten a URL, go to the provided endpoint and input the URL to shorten. You can either use curl or Api client

```
curl -X POST "http://localhost:3003/api/v1/urls" \
-H "X-USER-EMAIL: <your_email>" \
-H "X-USER-TOKEN: <your_api_token>" \
-d 'original=https://www.mongodb.com/docs/mongoid/current/reference/queries/#condition-syntax'
```

3. **Custom Short URLs:**
  - Access the specified feature/endpoint, which was returned from the api, to create custom short aliases for URLs.

## API Endpoints

The application provides the following API endpoints:
- `POST /api/v1/urls`: Shorten a new URL.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a pull request.

## License

The ShortenURL project is open-sourced under the [MIT License](LICENSE).

---

Feel free to enhance the sections as needed and include specific details about how to interact with your application, its features, any limitations, or additional instructions. Also, provide information on how contributors can participate.
