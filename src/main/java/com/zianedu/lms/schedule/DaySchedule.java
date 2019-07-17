package com.zianedu.lms.schedule;

import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.service.ScheduleService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class DaySchedule extends QuartzJobBean {

    private ApplicationContext context;

    @Override
    protected void executeInternal(JobExecutionContext ex) throws JobExecutionException {
        context = (ApplicationContext) ex.getJobDetail().getJobDataMap().get("applicationContext");
        try {
            executeJob(ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void executeJob(JobExecutionContext ex) throws Exception {

            ScheduleService scheduleService = (ScheduleService)context.getBean("scheduleService");
            scheduleService.daySchedule();
    }
}
