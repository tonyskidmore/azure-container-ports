FROM python:3.9-slim


WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make ports 5000 (HTTP) and 5001 (TCP) available to the world outside this container
EXPOSE 5000 5001

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
