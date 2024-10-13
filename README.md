# 🎭 **Theater Chatbot - Sign Stage**

This project is the final version of a **cross-platform mobile application** developed to help users interact with the ticketing system of a hypothetical theater. The app integrates a chatbot that allows users to engage with the theater through a conversational interface, such as **Messenger** or similar chat apps. The chatbot enhances the user experience by providing essential information about shows, assisting with ticket bookings, and managing other requests in an intuitive and user-friendly manner.

## 🚀 **Overview**
The mobile application allows users to interact with the theater’s ticketing system for **two different halls**, each featuring distinct performances with **afternoon and evening shows**. The chatbot is powered by **Retrieval-Augmented Generation (RAG)** and **function calling**, allowing it to interpret user queries, retrieve relevant information, and respond accurately based on real-time data from the theater’s system.

For actions like booking tickets, canceling reservations, or submitting complaints, the chatbot also provides **quick action buttons**, helping users seamlessly navigate to the necessary pages or forms.

The theater ensures accessibility by offering special accommodations for **hearing-impaired users**, including **seats near interpreters** and **shows with supertitles**.

## 🎯 **Key Features**
- **Real-time Show Information**: Users can ask the chatbot for information about current performances, including which hall they are being shown in and the schedule for afternoon or evening showings.
- **Ticket Booking**: The application walks users through booking tickets for specific shows, allowing them to select seats, confirm the reservation, or cancel before finalizing.
- **Ticket Cancellation**: Users can cancel previously booked tickets directly through the chatbot in a few simple steps.
- **Complaints and Feedback**: The chatbot assists users in submitting complaints or feedback and can escalate issues to human agents when necessary.
- **Accessibility Support**: The app includes **seating near interpreters** for hearing-impaired users and provides **supertitles** for certain shows, enhancing the accessibility of performances.
- **Error Handling**: The chatbot uses confirmation dialogs to ensure that no unwanted actions are taken. If the system detects repeated misunderstandings, it escalates to a human agent to assist the user.
  
## 💡 **How It Works**
The chatbot utilizes **intent recognition** to understand user requests in natural language. Based on the detected intent (e.g., checking show times, booking a ticket, or submitting a complaint), it retrieves the appropriate information and responds accordingly. Additionally, the system can trigger **function calls** for specific actions like booking a seat or handling a complaint.

The communication between the chatbot’s **Large Language Model (LLM)** and the app’s **frontend** is facilitated by a **Flask server**, which manages requests and responses to ensure smooth operation.

### **Fully Functional Backend**
Apart from the chatbot, the application includes a **fully functional backend system** that enables users to:
- Book tickets
- Cancel tickets
- Access information on shows
- Submit complaints
- Get information about the theater
  
These operations can be completed both through the chatbot and directly via the app interface, offering users multiple interaction options.

## 🛠 **Tech Stack**
- **Flutter (Dart)**: Cross-platform framework used to build the mobile app, making it available on both **iOS** and **Android** devices.
- **Flask (Python)**: Backend framework that manages the communication between the mobile app’s frontend and the chatbot server, handling queries and responses.
- **Large Language Model (LLM)**: Utilized for natural language processing, enabling the chatbot to **understand user queries** and **identify user intent**.
- **Retrieval-Augmented Generation (RAG)**: Ensures the chatbot retrieves **relevant information** from the theater's backend system based on user queries, enhancing real-time information delivery.

## 📁 **Installation & Usage**
1. Clone the repository from GitHub:
   ```bash
   git clone https://github.com/your-repo/theater-chatbot.git

2. Navigate to the lib/ai_script directory:
   ```bash
   cd lib/ai_script

3. Run the cells of the mistral-chat-with-rag.ipynb notebook to instantiate the server.
4. Connect your mobile phone to your development environment or use an emulator to start the Flutter app:
    ```bash
    flutter run

5. You are all set!

## 📹 **Demo Video**
Check out the [demo video](https://youtu.be/4aERZS8aAxI?si=49Q5UM2pSCIIjJrP) to see the app and chatbot in action, showcasing their key features and how they provide a smooth, mobile-friendly user experience.
