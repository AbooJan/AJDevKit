//
//  RegexDefine.h
//  jianzhimao_enterprise
//
//  Created by 林liouly on 15/8/27.
//  Copyright (c) 2015年 joiway. All rights reserved.
//
///正则表达式宏

#ifndef jianzhimao_enterprise_RegexDefine_h
#define jianzhimao_enterprise_RegexDefine_h

///邮箱
#define REGXEX_EMAIL                    @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

///密码
#define REGXEX_PASSWORD                 @"^[a-zA-Z0-9]\\w{5,15}$"

///用户名
#define REGXEX_USERNAME                 @"^[a-zA-Z0-9]{2,15}$"

///手机号码
#define REGXEX_PHONE                    @"^((13[0-9])|(147)|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$"

///固话
#define REGXEX_TEL_NUMBER               @"^0(10|2[0-5789]|\\d{3})[\\-]?\\d{7,8}$"

///验证码
#define REGXEX_CHECKCODE                @"^\\d{6}"

///字母+数字
#define REGXEX_LETTER_AND_NUM           @"[a-zA-Z\\d]"

///浮点数
#define REGXEX_FLOAT_NUM                @"^[1-9]d*.d*|0.d*[1-9]d*$"

///整数
#define REGXEX_UINTEGER                 @"^[0-9]*[1-9][0-9]*$"

///支付密码
#define REGEX_PAYPW                     @"^[0-9]{1,6}$"

///固话+手机
#define REGEX_TEL_PHONE                 @"^([0-9\\-]){0,15}$"

#define REGEX_NAME                      @"^([\u4E00-\u9FA5]|[a-zA-Z]){1}.*$"
#define REGEX_NUMBER                    @"^\\d{13}$"

///银行卡
#define REGEX_BANKCARD                  @"^(\\d{4}(?: )){3}\\d{4}$"

///金额（正整数）
#define REGEX_INTPRICE                  @"^[1-9]{1}\\d*$"

///评论文本
#define REGEX_COMMENTTEXT               @"^([\u4E00-\u9FA5a-zA-Z0-9])*$"

///支付宝实名
#define REGEX_ALIPAYNAME                @"^([\u4E00-\u9FA5a-zA-Z\\s.]){0,10}$"


#endif
