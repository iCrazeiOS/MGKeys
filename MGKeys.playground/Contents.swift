import UIKit
import CommonCrypto

func CalculateObfuscatedKey(key: String) -> String {
    let pre = ("MGCopyAnswer" + key as String)
    var hash = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(pre, UInt32(pre.count), &hash)
    let md5Data = NSData(bytes: hash, length: Int(CC_MD5_DIGEST_LENGTH))
    let obfuscatedKey = md5Data.base64EncodedString()
    return obfuscatedKey.substring(to: String.Index(encodedOffset: 22))
}

func Md5StringForObfuscatedKey(key: String) -> String? {
    guard key.count != 0 else {
        return nil
    }
    
    let base64 = key + "=="
    let data = Data(base64Encoded: base64)
    guard data!.count == 16 else {
        return nil
    }
    
    let bytes = data!.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) in
        Array(UnsafeBufferPointer(start: bytes, count: data!.count / MemoryLayout<UInt8>.stride))
    }
    
    return bytes.map( { String(format: "%02hhx", $0) } ).joined()
}

func obfuscatedToMD5(_ filename: String) -> Int {
    errno = 0
    let realPath = Bundle.main.path(forResource: filename, ofType: "txt")
    if freopen(realPath, "r", stdin) == nil {
        perror(realPath)
        return 1
    }
    while let line = readLine() {
        print(Md5StringForObfuscatedKey(key: line)!)
    }
    return 0
}

// 0D3qCmmfJ/i1mpmjOsV7EA - confirmed
CalculateObfuscatedKey(key: "ScreenSerialNumber")

// TqAfAH10ANDgiG7V2u8BkQ - confirmed
CalculateObfuscatedKey(key: "FrontFacingCameraHFRVideoCapture720pMaxFPS")

// mL1lk3ZVGDFUQhxU9YLW6Q - confirmed
CalculateObfuscatedKey(key: "FrontFacingCameraHFRVideoCapture1080pMaxFPS")

// 0AJUv/uYPsRiZNGpWJ7zfg - confirmed
CalculateObfuscatedKey(key: "DeviceSupportsSiriSpokenMessages")

// YiUtBQygkHRhLcdO3LFB4A - confirmed
CalculateObfuscatedKey(key: "DeviceSupportsTelephonyOverUSB")

// feC7TgoAAKLjn/KU8JAKFA - confirmed
CalculateObfuscatedKey(key: "DeviceSupportsExternalHDR")

// XriAxQ+JY1z5nt5f3ftXVw - confirmed
CalculateObfuscatedKey(key: "DeviceSupportsCameraHaptics")

// SZy8T5ma/+a0wJc0ntiaaA - confirmed
CalculateObfuscatedKey(key: "PhoneNumber2")

// 2zyzecwSf2ZYRpB3tuQhOQ
CalculateObfuscatedKey(key: "WirelessSplitterCapability")

// q3JBrhzy5fyJ1+LAITPW0w
CalculateObfuscatedKey(key: "HearingAidLEA2Capability")

// M+WPVivF4iTnm1CC8c6h+A (haptic) - guessed
CalculateObfuscatedKey(key: "pre-warm-disabled")

// jaJWtlotaa+Y41lCs7NVHg
CalculateObfuscatedKey(key: "BackFacingCameraLowLightingCapability")

// hnXJ1OpiiIL0+p3jUG/XxQ
CalculateObfuscatedKey(key: "rear-cam-super-wide-capability")

// L8CqbJeM+rf7l7NSOjnAHg
CalculateObfuscatedKey(key: "DeviceSupportsPortraitLightEffectFilters2")

// obfuscatedToMD5("obfuscated")
