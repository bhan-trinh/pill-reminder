#### Description
Pill Reminder is a smart medication management system that simplifies pill-taking with an intuitive, accessible interface designed for easy navigation. Users can snap a photo of their prescription label, and the app will automatically scan and extract dosing instructions. These instructions are then sent to an automatic pill dispenser, which releases the correct dose at the right time of day.

To prevent missed doses, Pill Reminder features a sound buzzer alert 'ding-dong', clear reminders, and real-time notifications. By combining convenience with safety, Pill Reminder helps users stay healthy and worry-free.

#### Inspiration
Incorrect medication dosing is one of the biggest hidden health risks. According to the WHO, up to 50% of medications are not taken as prescribed, and dosage mistakes alone contribute to 125,000 preventable deaths in the U.S. every year.

This issue is even more serious among older adults: at least 1 in 4 seniors make dosing errors. As elders manage multiple prescriptions alongside challenges like memory decline, vision loss, or reduced dexterity, the risks only increase.

Motivated by this urgent need, we created Pill Reminder — a solution designed to take the guesswork out of medication management and help people, especially seniors, stay safe, independent, and confident.

#### How we built it
We integrated both software and hardware to create a smart pill dispenser that makes medication management easier. Here's how we created it:

Figma: Designed a responsive user interface with clear, high-contrast elements and intuitive navigation for an enhanced user experience.
Flutter: Developed the user interface for prescription scanning, pill scheduling, and reminders.
OCR: Scanned prescriptions to retrieve drug names, doses, and times.
Gemini AI: Analyzed scanned data to provide structured medication directions.
Flask Backend: Processed user requests, saved data, and communicated with the Arduino dispenser over the serial port.
MongoDB Atlas: Stored user profiles, prescriptions, and medication regimens in a secure cloud database.
Arduino + Servo Motor: Controlled the pill dispenser to release the correct pill at the appropriate time.
Serial Communication: Enabled seamless interaction between the backend and hardware during pill distribution.

#### Challenges we ran into
OCR Accuracy: Getting accurate text recognition from prescription labels was difficult due to various fonts, label formats, and occasionally handwriting.
Hardware Integration: Ensuring that the Arduino and servo motor could accurately release the correct pills at the proper moment was difficult. To achieve correct synchronization, the hardware and backend communication needed to be fine-tuned.
User Interface: It was difficult to design an intuitive user interface for elders who were unfamiliar with technology. We prioritized simplicity and accessibility, yet iterating to fulfill all user needs required time.
