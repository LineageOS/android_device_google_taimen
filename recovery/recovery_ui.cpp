/*
 * Copyright (C) 2019 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <string>

#include <android-base/logging.h>
#include <bootloader_message/bootloader_message.h>
#include <misc_writer/misc_writer.h>
#include <recovery_ui/device.h>
#include <recovery_ui/screen_ui.h>

using android::hardware::google::pixel::MiscWriter;
using android::hardware::google::pixel::MiscWriterActions;

// Wipes the provisioned flag as part of data wipe.
static bool WipeProvisionedFlag() {
    MiscWriter misc_writer(MiscWriterActions::kClearDarkThemeFlag);
    if (!misc_writer.PerformAction()) {
        LOG(ERROR) << "Failed to clear the dark theme flag";
        return false;
    }
    LOG(INFO) << "Provisioned flag wiped successful";
    return true;
}

class TaimenDevice : public Device {
  public:
    TaimenDevice(ScreenRecoveryUI* ui) : Device(ui) {}

    // Hook to wipe user data not stored in /data.
    bool PostWipeData() override {
        // Try to do everything but report a failure if anything wasn't successful.
        bool total_success = true;
        auto ui = GetUI();
        ui->Print("Wiping provisioned flag...\n");
        if (!WipeProvisionedFlag()) {
            total_success = false;
        }
        return total_success;
    }
};

Device* make_device() {
    return new TaimenDevice(new ScreenRecoveryUI);
}
