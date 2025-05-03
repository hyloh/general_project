#include <GL/glut.h>
#define _USE_MATH_DEFINES
#include <cmath>
#include <string>

// Global variables
int windowWidth = 800;
int windowHeight = 600;
float rotationAngle = 0.0f;
bool isAnimating = true;

// Function to draw a simpler lotus flower that will display properly
void drawLotus(float x, float y, float size, float angle) {
    // Save current transformation matrix
    glPushMatrix();

    // Translate to position and rotate
    glTranslatef(x, y, 0.0f);
    glRotatef(angle, 0.0f, 0.0f, 1.0f);

    // Draw petals (8 triangular petals)
    int numPetals = 8;

    // Outer petals (pink)
    glColor3f(0.95f, 0.6f, 0.75f); // Pink color
    for (int i = 0; i < numPetals; i++) {
        float angle1 = (float)i * 2.0f * M_PI / numPetals;
        float angle2 = (float)(i + 0.5) * 2.0f * M_PI / numPetals;
        float angle3 = (float)(i + 1) * 2.0f * M_PI / numPetals;

        glBegin(GL_TRIANGLES);
        glVertex2f(0.0f, 0.0f); // Center
        glVertex2f(size * cos(angle1), size * sin(angle1));
        glVertex2f(size * cos(angle3), size * sin(angle3));
        glEnd();
    }

    // Inner petals (lighter pink, smaller and rotated)
    glColor3f(1.0f, 0.7f, 0.85f); // Lighter pink
    for (int i = 0; i < numPetals; i++) {
        float angle1 = (float)(i + 0.25) * 2.0f * M_PI / numPetals;
        float angle2 = (float)(i + 0.5) * 2.0f * M_PI / numPetals;
        float angle3 = (float)(i + 0.75) * 2.0f * M_PI / numPetals;

        glBegin(GL_TRIANGLES);
        glVertex2f(0.0f, 0.0f); // Center
        glVertex2f(size * 0.6f * cos(angle1), size * 0.6f * sin(angle1));
        glVertex2f(size * 0.6f * cos(angle3), size * 0.6f * sin(angle3));
        glEnd();
    }

    // Center of the lotus (yellow)
    glColor3f(1.0f, 0.9f, 0.2f); // Golden yellow
    glBegin(GL_POLYGON);
    for (int i = 0; i < 360; i += 15) {
        float radian = i * M_PI / 180.0f;
        glVertex2f(size * 0.25f * cos(radian), size * 0.25f * sin(radian));
    }
    glEnd();

    // Restore transformation matrix
    glPopMatrix();
}

// Function to draw a lantern
void drawLantern(float x, float y, float size, float r, float g, float b) {
    glPushMatrix();
    glTranslatef(x, y, 0.0f);

    // Lantern top
    glColor3f(0.6f, 0.4f, 0.2f);
    glBegin(GL_QUADS);
    glVertex2f(-0.1f * size, 0.2f * size);
    glVertex2f(0.1f * size, 0.2f * size);
    glVertex2f(0.1f * size, 0.3f * size);
    glVertex2f(-0.1f * size, 0.3f * size);
    glEnd();

    // Lantern string
    glColor3f(0.8f, 0.8f, 0.8f);
    glBegin(GL_LINES);
    glVertex2f(0.0f, 0.3f * size);
    glVertex2f(0.0f, 0.5f * size);
    glEnd();

    // Lantern body (main part)
    glColor3f(r, g, b);
    glBegin(GL_QUADS);
    glVertex2f(-0.15f * size, -0.2f * size);
    glVertex2f(0.15f * size, -0.2f * size);
    glVertex2f(0.15f * size, 0.2f * size);
    glVertex2f(-0.15f * size, 0.2f * size);
    glEnd();

    // Lantern decoration lines
    glColor3f(0.9f, 0.9f, 0.2f); // Brighter yellow
    glLineWidth(2.0f);
    glBegin(GL_LINES);
    glVertex2f(-0.15f * size, 0.1f * size);
    glVertex2f(0.15f * size, 0.1f * size);

    glVertex2f(-0.15f * size, 0.0f * size);
    glVertex2f(0.15f * size, 0.0f * size);

    glVertex2f(-0.15f * size, -0.1f * size);
    glVertex2f(0.15f * size, -0.1f * size);
    glEnd();

    // Lantern bottom
    glColor3f(0.6f, 0.4f, 0.2f);
    glBegin(GL_QUADS);
    glVertex2f(-0.1f * size, -0.3f * size);
    glVertex2f(0.1f * size, -0.3f * size);
    glVertex2f(0.1f * size, -0.2f * size);
    glVertex2f(-0.1f * size, -0.2f * size);
    glEnd();

    glPopMatrix();
}

// Function to draw the lantern connecting strings (now horizontal)
void drawLanternStrings() {
    glColor3f(0.8f, 0.8f, 0.8f);
    glLineWidth(1.0f);
    glBegin(GL_LINES);

    // Horizontal string connecting all lanterns
    glVertex2f(-0.85f, 0.88f);  // Left
    glVertex2f(0.85f, 0.88f);   // Right

    glEnd();
}

// Function to draw multiple lanterns in a horizontal line at the top
void drawLanterns() {
    // First draw the string that connects all lanterns
    drawLanternStrings();

    // Draw 5 lanterns in a horizontal line with different colors
    float colors[5][3] = {
        {0.9f, 0.5f, 0.9f},  // Purple
        {0.9f, 0.5f, 0.7f},  // Pink
        {0.9f, 0.7f, 0.5f},  // Orange
        {0.8f, 0.8f, 0.5f},  // Light yellow
        {0.9f, 0.8f, 0.2f}   // Orange yellow
    };

    // Spacing between lanterns horizontally
    for (int i = 0; i < 5; i++) {
        float x = -0.7f + i * 0.35f;  // Adjust spacing between lanterns
        drawLantern(x, 0.7f, 0.35f, colors[i][0], colors[i][1], colors[i][2]); // Smaller size (0.35 instead of 0.5)
    }
}

// Function to draw corner decorations
void drawCornerDecorations() {
    // Draw geometric corner decorations
    glColor3f(0.7f, 0.7f, 1.0f);
    glLineWidth(2.0f);

    // Top-left corner
    glBegin(GL_LINES);
    glVertex2f(-0.95f, 0.95f);
    glVertex2f(-0.75f, 0.95f);

    glVertex2f(-0.95f, 0.95f);
    glVertex2f(-0.95f, 0.75f);

    // Diagonal lines
    for (int i = 0; i < 5; i++) {
        glVertex2f(-0.95f + 0.04f * i, 0.95f);
        glVertex2f(-0.95f, 0.95f - 0.04f * i);
    }
    glEnd();

    // Top-right corner
    glBegin(GL_LINES);
    glVertex2f(0.95f, 0.95f);
    glVertex2f(0.75f, 0.95f);

    glVertex2f(0.95f, 0.95f);
    glVertex2f(0.95f, 0.75f);

    // Diagonal lines
    for (int i = 0; i < 5; i++) {
        glVertex2f(0.95f - 0.04f * i, 0.95f);
        glVertex2f(0.95f, 0.95f - 0.04f * i);
    }
    glEnd();

    // Bottom-left corner
    glBegin(GL_LINES);
    glVertex2f(-0.95f, -0.95f);
    glVertex2f(-0.75f, -0.95f);

    glVertex2f(-0.95f, -0.95f);
    glVertex2f(-0.95f, -0.75f);

    // Diagonal lines
    for (int i = 0; i < 5; i++) {
        glVertex2f(-0.95f + 0.04f * i, -0.95f);
        glVertex2f(-0.95f, -0.95f + 0.04f * i);
    }
    glEnd();

    // Bottom-right corner
    glBegin(GL_LINES);
    glVertex2f(0.95f, -0.95f);
    glVertex2f(0.75f, -0.95f);

    glVertex2f(0.95f, -0.95f);
    glVertex2f(0.95f, -0.75f);

    // Diagonal lines
    for (int i = 0; i < 5; i++) {
        glVertex2f(0.95f - 0.04f * i, -0.95f);
        glVertex2f(0.95f, -0.95f + 0.04f * i);
    }
    glEnd();
}

// Function to render text
void renderText(const char* text, float x, float y, float scale = 1.0f) {
    glPushMatrix();
    glTranslatef(x, y, 0.0f);
    glScalef(scale * 0.0005f, scale * 0.0005f, 1.0f);

    for (const char* c = text; *c != '\0'; c++) {
        glutStrokeCharacter(GLUT_STROKE_MONO_ROMAN, *c);
    }

    glPopMatrix();
}

// Display function
void display() {
    // Clear the color buffer
    glClearColor(0.0f, 0.0f, 0.4f, 1.0f); // Dark blue background
    glClear(GL_COLOR_BUFFER_BIT);

    // Enable blending for transparency
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    // Draw the main scene elements
    drawCornerDecorations();
    drawLanterns();

    // Draw message text - now on the right side
    glColor3f(1.0f, 1.0f, 1.0f);
    renderText("HAPPY", 0.35f, 0.0f, 2.0f);     // Moved to right
    renderText("WESAK DAY", -0.065f, -0.2f, 2.0f); // Moved to right and down

    // Draw the rotating lotus flower on the left
    drawLotus(-0.5f, 0.0f, 0.35f, rotationAngle); // Moved to left and made larger

    // Draw blessing message (centered at bottom)
    glColor3f(0.7f, 0.7f, 0.7f);
    renderText("May your life be full of blessing, peace and", -0.7f, -0.6f, 0.6f);
    renderText("happiness on this day of enlightenment.", -0.6f, -0.7f, 0.6f);

    // Disable blending
    glDisable(GL_BLEND);

    // Swap buffers
    glutSwapBuffers();
}

// Reshape function
void reshape(int width, int height) {
    windowWidth = width;
    windowHeight = height;

    // Set the viewport
    glViewport(0, 0, width, height);

    // Set the projection matrix
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    // Maintain aspect ratio
    float aspectRatio = (float)width / (float)height;
    if (width <= height) {
        glOrtho(-1.0, 1.0, -1.0 / aspectRatio, 1.0 / aspectRatio, -1.0, 1.0);
    }
    else {
        glOrtho(-1.0 * aspectRatio, 1.0 * aspectRatio, -1.0, 1.0, -1.0, 1.0);
    }

    // Switch back to modelview matrix
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Timer function for animation
void timer(int value) {
    if (isAnimating) {
        rotationAngle += 0.5f;  // Slow rotation speed
        if (rotationAngle > 360.0f) {
            rotationAngle -= 360.0f;
        }
    }

    // Redisplay
    glutPostRedisplay();

    // Reset timer
    glutTimerFunc(16, timer, 0); // ~60 FPS
}

// Keyboard function
void keyboard(unsigned char key, int x, int y) {
    switch (key) {
    case 27: // ESC key
        exit(0);
        break;
    case ' ': // Space key
        isAnimating = !isAnimating;
        break;
    }

    glutPostRedisplay();
}

// Main function
int main(int argc, char** argv) {
    // Initialize GLUT
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_ALPHA);
    glutInitWindowSize(windowWidth, windowHeight);
    glutCreateWindow("Happy Wesak Day");

    // Register callbacks
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);
    glutTimerFunc(16, timer, 0);

    // Enter the main loop
    glutMainLoop();

    return 0;
}
