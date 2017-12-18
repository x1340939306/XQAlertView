# XQAlertView
UIAlertView，UIActionSheet，UIAlertController封装，一句代码即可，iOS任何系统都可以使用

使用方式 pod 'XQAlertView'

[XQAlertView creatAlertView:@"提示" message:@"删除后，xxxxx，确定删除吗？" cancel:@"取消" sure:@"确定" handler:^(NSString *type) {
        if ([type isEqualToString:@"确定"]) {
        }
} delegate:self otherButtonTitles:nil, nil];
