//DSA SECTION 11
//GROUP 10 MELANIE PERKINS
//MEMBERS 1: LOH HUI YI A23CS0106 
//MEMBERS 2: HAZIQ BIN SHAHMEN A23CS0082 
//MEMBERS 3: TAI YI TIAN A23CS0272

#include <iostream>
#include <fstream>
#include <string>

using namespace std;

// Define a structure for patient records
struct Patient {
    string name;
    string appointmentTime; // Format: HH:MM
    Patient* next; // Pointer for linked list

    // Constructor
    Patient(string n, string time) : name(n), appointmentTime(time), next(nullptr) {}
};

// Function to validate time format (HH:MM)
bool isValidTime(const string& time) {
    if (time.length() != 5 || time[2] != ':') {
        return false;
    }
    
    // Check if all other characters are digits
    for (int i = 0; i < 5; i++) {
        if (i != 2 && !isdigit(time[i])) {
            return false;
        }
    }
    
    // Extract hours and minutes
    int hours = stoi(time.substr(0, 2));
    int minutes = stoi(time.substr(3, 2));
    
    // Validate hours and minutes
    if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
        return false;
    }
    
    return true;
}

// Function to parse input file and load patients into a linked list
Patient* loadPatientsFromFile(const string& inputFile) {
    ifstream inFile(inputFile);
    Patient* head = nullptr;
    Patient* tail = nullptr;

    string line;
    int lineNumber = 1;
    while (getline(inFile, line)) {
        auto commaPos = line.find(',');
        if (commaPos != string::npos) { // Check if comma exists in the line
            string name = line.substr(0, commaPos);
            string time = line.substr(commaPos + 1);

        if (!isValidTime(time)) {
                cout << "Error: Invalid time format at line " << lineNumber<< ": " << time << endl;
                cout << "Time should be in 24-hour format (HH:MM)" <<endl<<endl;
                lineNumber++;
                continue;  // Skip this invalid record
            }
            Patient* newPatient = new Patient(name, time);
            if (!head) {
                head = tail = newPatient;
            } else {
                tail->next = newPatient;
                tail = newPatient;
            }
            lineNumber++;
        }
        else{
            cout<<"Error: Invalid format at line "<<lineNumber<<": "<<line<<endl<<endl;
        }
    }
    inFile.close();
    return head;
}

// Sequential sort function to sort linked list by appointment time
Patient* sequentialSort(Patient* head) {
    if (!head || !head->next) {
        return head;
    }

    for (Patient* i = head; i->next != nullptr; i = i->next) {
        for (Patient* j = i->next; j != nullptr; j = j->next) {
            if (j->appointmentTime < i->appointmentTime) {
                swap(i->name, j->name);
                swap(i->appointmentTime, j->appointmentTime);
            }
        }
    }
    return head;
}

// Function to write sorted patients to an output file
void writePatientsToFile(Patient* head, const string& outputFile) {
    ofstream outFile(outputFile);
    if (!outFile) {
        cout << "Error: Unable to open output file." << endl;
        return;
    }

    Patient* current = head;
    while (current) {
        outFile << current->name << "," << current->appointmentTime << endl;
        current = current->next;
    }
    outFile.close();
}

// Function to free memory allocated for the linked list
void freeLinkedList(Patient* head) {
    while (head) {
        Patient* temp = head;
        head = head->next;
        delete temp;
    }
}

//check if the input file is valid
bool checkFile(string& file) {

    // Check if file has .txt 
    if(file.length() < 4 || file.substr(file.length() - 4) != ".txt") {
        cout << "Error: File must have .txt" << endl;
        return false;
    }

    // Check if file exists
    ifstream fileCheck(file);
    if(!fileCheck) {
        cout << "Error: File does not exist." << endl;
        return false;
    }

    // Check if file is empty
    fileCheck.seekg(0, ios::end);
    if(fileCheck.tellg() == 0) {
        cout << "Error: File is empty." << endl;
        fileCheck.close();
        return false;
    }

    fileCheck.close();

    return true;
}

int main() {
    string inputFile;
    string outputFile;

    cout<<"Enter input file name: ";
    cin>>inputFile;

    if(checkFile(inputFile)) {

        //Load patients from input file into linked list
        Patient* patients = loadPatientsFromFile(inputFile);

        //Sort patients by appointment time using sequential sort
        patients = sequentialSort(patients);

        //prompt user for output file name
        cout<<"Enter output file name: ";
        cin>>outputFile;

        //Write sorted patients to output file
        writePatientsToFile(patients, outputFile);

        //Free allocated memory
        freeLinkedList(patients);

        cout << "Patients sorted and written to " << outputFile << endl;
    }

    system("pause");
    return 0;
}
