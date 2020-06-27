FROM ubuntu:18.04


#ADD ./ssmtp.conf /etc/ssmtp/ssmtp.conf
ADD entrypoint.sh entrypoint.sh
RUN chmod 0744 /entrypoint.sh

RUN apt-get update && apt-get install -y ssmtp curl cron

# Copy hello-cron file to the cron.d directory
COPY cronejob /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Apply cron job
RUN crontab /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
