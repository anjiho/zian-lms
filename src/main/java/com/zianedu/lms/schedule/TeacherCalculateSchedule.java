package com.zianedu.lms.schedule;

import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.repository.TeacherCalculateRepository;
import com.zianedu.lms.service.ScheduleService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * 강사 정산 스케쥴링 JOB
 */
public class TeacherCalculateSchedule extends QuartzJobBean {

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

        boolean isSchedule = ConfigHolder.isSchedule();
        if (isSchedule) {
            ScheduleService scheduleService = (ScheduleService)context.getBean("scheduleService");
            scheduleService.calculateTeacherSaleGoods();
        }
    }
}
