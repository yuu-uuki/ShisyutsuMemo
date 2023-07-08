//
//  DefaultsKeys+.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/09.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var spentTimes: DefaultsKey<Int> { .init("spentTimes", defaultValue: 0) }
}
