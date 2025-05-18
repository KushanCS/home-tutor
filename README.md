# Home Tutor Project

## Overview
The **Home Tutor** project is a Java-based web application built using the Maven build tool. It is configured to use a `.smarttomcat` directory for deployment and web configuration.

## Project Structure
- **Language**: Java
- **Build Tool**: Maven
- **Web Framework**: Configured for deployment with Tomcat
- **Configuration Files**:
    - `web.xml`: Located at `.smarttomcat/home-tutor/conf/web.xml`
    - Web root: `.smarttomcat/home-tutor/conf` (relative to `/WEB-INF`)

## Key Features
- Modular structure defined in `home-tutor.iml`.
- Excludes `.smarttomcat` folder from the module content.
- Configured for web deployment using Tomcat.

## Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone git@github.com:KushanCS/home-tutor.git
   cd home-tutor
   
2. Configure Tomcat:

   - Add a Tomcat server in IntelliJ IDEA.
   - Set the deployment descriptor to .smarttomcat/home-tutor/conf/web.xml.

3. Build the Project:

    ```bash
    mvn clean install
    ```
   
4. Run the Application:
- Start the Tomcat server from IntelliJ IDEA.
- Access the application in your browser.

## Folder Exclusions

The .smarttomcat folder is excluded from the module content to avoid unnecessary indexing.