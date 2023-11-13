# Shortener Service

ShortenURL is a simple URL shortening service built using Ruby on Rails.

## Features

- **URL Shortening:** Shorten long URLs into more manageable shortened versions.
- **Custom Short URLs:** Ability to create custom aliases for URLs.
- **Expiration:** Set expiration dates for shortened URLs.

## Installation
### Locally
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
### Live product
Please move straight to the Usage session

## Usage

1. **Shorten a URL:**

   1.1 Live product
    - First, you will need credentials to call the api, please use one of these 2 ways:
      + Create an account using your email, [please go to this site](https://shortener-service-api.onrender.com/). After you submit, please check your email inbox for credentials / instructions (please also check spam folder as well).
      + In case you failed to create the account (or too lazy for that), use the default credentials: test@example.com / token_1
    - To shorten a URL, go to the provided endpoint and input the URL. You can either use curl or Api client

    ```
    curl -X POST "https://shortener-service-api.onrender.com/api/v1/urls" \
    -H "X-USER-EMAIL: <your_email>" \
    -H "X-USER-TOKEN: <your_api_token>" \
    -d 'original=https://www.mongodb.com/docs/mongoid/current/reference/queries/#condition-syntax'
    ```
    1.2 Local host
      - First please start the server `rails s -p 3003`
      - Replace the `https://shortener-service-api.onrender.com/` host with your localhost and create a user by access the root page. Please not that you will need a mail client like mailcatcher to view the mail or you may check the rails log for the credentials
2. Expected output:
  - Success:
    ```
    {"id":"12e7a835-13b9-434d-ab46-c0ef7a02329a","shortened_url":"https://shortener-service-api.onrender.com/urls/3e3f1dc","refs":{"self":"https://shortener-service-api.onrender.com/api/v1/urls"},"code":200,"expires_at":"Monday, November 13, 2023 03:08 AM"}%
    ```
  - Failed
    ```
      {"code":422,"errors":["Original url can't be blank","Original url is invalid","Shortened url can't be blank"]}%
    ```

3. **Access Short URLs:**
  - Paste the shortened url, which was returned from the api to access the original page.
  **_PLEASE NOTE THAT EACH SHORTENED URL WILL BE EXPIRED AND CLEANED UP AFTER 4 HOURS_**

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

## Real life problems
1. **API Rate Limiting**
We should make sure our api won't be abused or spammed. We can install some tools at the Middleware to set the limitation such as `rack-attack` gem

2. **Errors monitoring**
We need to keep an eye on how things work on the server to detect errors and fix it. This could be achieved by installing some tracking tools such as: Sentry, Bugsnag, etc...

3. **Api/Redirection timeout**
  Sometime, maybe the redirect would be failed (due to the original url is not exist anymore, internet connection, etc..)
  We should implement a timeout for the redirection, if it is too long, we should show him the connection is timeout error and close the request:
      - Create a view show.html.erb view for RedirectionsController#show
      - Apply some JS to set timeout for redirection, if the time is exceeded and there is still no redirection, then we can render the error page.

  We also need to implement the api timeout error so the api request won't hang too long. A famous gem would help [rack-timeout](https://rubygems.org/gems/rack-timeout)
