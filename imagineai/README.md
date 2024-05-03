# Imagine Ai
# Text-to-Image Generation Mobile Application

## Overview
Welcome to our innovative mobile application that merges the power of AI with Flutter to create a seamless experience in generating images from text. This project not only transforms text into captivating visuals but also integrates various features like background removal, image expansion, cropping, and robust authentication methods for user convenience.

## Features
- **Text Input**: Users can input any text, from simple phrases to complex sentences.
- **Image Generation**: Utilizing advanced AI algorithms, the application converts text into visually appealing images.
- **Customization**: Users can customize various aspects of the generated images, including style, color palette, and more.
- **Authentication Options**: The app offers multiple authentication methods, including Google Sign-In, Facebook Login, mobile number, and email/password authentication, ensuring a secure and seamless experience.
- **Background Removal**: Utilizing AI-based background removal, users can isolate subjects in images effortlessly.
- **Image Expansion and Cropping**: The app provides tools for expanding images and cropping them to desired dimensions, enhancing user control over image output.

## AI Model
- **Model Name**: SD-XL 1.0-base
- **Developed by**: Stability AI
- **Model Type**: Diffusion-based text-to-image generative model
- **Description**: SD-XL consists of an ensemble of experts pipeline for latent diffusion. In a two-stage pipeline, the base model generates latents of the desired output size, and a specialized high-resolution model applies SDEdit technique to the generated latents. The model utilizes two fixed, pretrained text encoders (OpenCLIP-ViT/G and CLIP-ViT/L).
- **Model Sources**: For research purposes, the [generative-models Github repository](https://github.com/Stability-AI/generative-models) provides implementations of popular diffusion frameworks. Clipdrop provides free SDXL inference.

## Technologies Used
- **Flutter**: Leveraging Flutter's versatility and performance for cross-platform mobile application development.
- **Firebase Authentication**: Integrating Firebase Authentication for secure and easy user authentication.
- **Firebase Cloud Firestore**: Storing user data securely using Firebase Cloud Firestore.
- **TensorFlow**: TensorFlow powers the AI models for background removal and text-to-image generation.

## Getting Started
To begin exploring this project:
1. Clone the repository to your local machine.
2. Install Flutter and its dependencies as per the official documentation.
3. Set up Firebase for authentication and Cloud Firestore for data storage.
4. Configure authentication providers such as Google Sign-In and Facebook Login in Firebase Console.
5. Run the application on an emulator or physical device to start generating images and utilizing authentication features.

## Contributing
We welcome contributions from developers of all levels. Here's how you can contribute:
- Report bugs or suggest new features by opening an issue.
- Fork the repository and submit pull requests to address existing issues or implement new functionality.
- Spread the word about the project and help grow the community.

## Acknowledgements
- We extend our gratitude to the Flutter and TensorFlow communities for their continuous support and contributions.
- Special thanks to Firebase for providing reliable authentication and data storage services.
- The advancements in AI technology, particularly the SD-XL model developed by Stability AI, have significantly influenced this project, pushing the boundaries of what's achievable in mobile application development.

## Contact
For any inquiries or feedback regarding this project, feel free to reach out to [developer](mailto:abubakaranjum065@gmail.com). Your feedback is invaluable to us!
