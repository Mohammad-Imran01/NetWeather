# NetWeather

NetWeather is a desktop weather application built using Qt C++ and MSVC 6.5. It leverages `QWebEngine` to display interactive weather maps and fetches real-time geographic and weather data from various web APIs.

## Features

- **Weather Maps**: Display interactive weather maps using `QWebEngine`.
- **Real-Time Data**: Retrieve up-to-date weather and geographic data from various web APIs.
- **User-Friendly Interface**: Intuitive and responsive GUI for easy navigation and interaction.

## Installation

### Prerequisites

Ensure you have the following installed:

- **Qt 6**: Cross-platform application framework.
- **MSVC 6.5**: Compiler for building the application.
- **QWebEngine**: Module for rendering web content within the application.
- **API Keys**: Obtain necessary API keys for accessing weather and geo data.

### Setting Up the Environment

1. **Add Libraries to Environment Variables**: Ensure paths to Qt and MSVC are added to your system's environment variables.
2. **Configure the Project**: Edit the `.pro` file to point to your build directories. Ensure paths for Qt and MSVC are correctly set.

### Building the Project

1. **Clone the Repository**:

    ```sh
    git clone https://github.com/Mohammad-Imran01/NetWeather.git
    cd NetWeather
    ```

2. **Run qmake**:

    ```sh
    qmake NetWeather.pro
    ```

3. **Compile the Project**:

    ```sh
    nmake
    ```

4. **Run the Application**:

    ```sh
    NetWeather.exe
    ```

## Usage

1. **Open the Application**: Launch NetWeather from your desktop or start menu.
2. **View Weather Maps**: Use the application interface to view interactive weather maps.
3. **Fetch Weather Data**: The application will automatically retrieve real-time weather and geo data.
4. **Interact with the Interface**: Utilize available features to analyze weather patterns and forecasts.

## Screenshots

Here is a sample screenshot of NetWeather:

![Example Screenshot](https://github.com/Mohammad-Imran01/NetWeather/blob/main/ss/smallMid.png)

## Contributing

If you'd like to contribute to NetWeather, please follow these guidelines:

1. **Fork the Repository**: Create your own fork of the repository.
2. **Create a Branch**: Make a new branch for your changes.
3. **Make Changes**: Implement your changes or new features.
4. **Submit a Pull Request**: Open a pull request describing your changes.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any questions or support, please contact:

- **Email**: [imranmbhd2412@gmail.com](mailto:imranmbhd2412@gmail.com)
