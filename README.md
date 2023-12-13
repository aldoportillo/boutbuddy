# BoutBuddy

BoutBuddy is a web application designed to bridge the gap between fighters, promoters, and fans in the world of combat sports. This platform facilitates the discovery and promotion of fight events, enables fighters to find and sign up for bouts, and allows fans to follow and attend events.

## Features

- **Event Creation and Management**: Promoters can create and manage events, setting up the foundation for bouts and inviting fighters to participate.
- **Fighter Profiles and Records**: Fighters can maintain their profiles, search for events, and track their match records over time.
- **Matchmaking**: A system that allows fighters to find opponents in their weight class, ensuring fair and competitive bouts.
- **Pre-Fight Engagement**: A public forum for fighters to engage with their fans and build up hype for upcoming fights.
- **Event Discovery**: Fans can discover events, follow their favorite fighters, and keep track of upcoming bouts.

## Getting Started

### Prerequisites

- Ensure you have Rails 7.0.8 installed.
- Ensure you have Ruby 3.2.1 installed.
- Ensure you have Postresql 14.9 installed.
- Ensure you have Bundler 2.4.6 installed.

### Installation

To get BoutBuddy up and running on your local machine, follow these steps:

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/aldoportillo/boutbuddy
    ```

2. Navigate to the application directory:

    ```bash
    cd BoutBuddy
    ```

3. Install the required Ruby gems by running Bundler (make sure you have Bundler installed):

    ```bash
    bundle install
    ```

4. Since this application uses PostgreSQL, ensure you have PostgreSQL installed and running on your machine. Then create and migrate the database:

    ```bash
    rails db:create db:migrate
    ```

5. To populate the database with initial data, run the sample data task:

    ```bash
    rake sample_data
    ```

6. Start the Rails server:

    ```bash
    rails server
    ```

7. Visit `http://localhost:3000` in your web browser to view the application.

## Contact

Aldo Portillo - [LinkedIn](https://www.linkedin.com/in/aldoportillo/) – [Instagram](https://www.instagram.com/portillo.mma/) – [Twitter](https://twitter.com/aldoportillodev)

Project Link: [https://github.com/aldoportillo/boutbuddy](https://github.com/aldoportillo/boutbuddy)

## ERD
![ERD](erd.png)
