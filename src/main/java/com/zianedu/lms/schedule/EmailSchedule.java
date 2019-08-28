package com.zianedu.lms.schedule;

import com.zianedu.lms.service.ScheduleService;
import com.zianedu.lms.service.UserService;
import com.zianedu.lms.utils.ZianUtils;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class EmailSchedule extends QuartzJobBean {

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
        UserService userService = (UserService)context.getBean("userService");
        if (!ZianUtils.isHoliday()) {
            userService.daumEmailSend();
            userService.daumEmailSend2();
        }
    }
}
