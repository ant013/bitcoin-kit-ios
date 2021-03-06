class AddressConverterChain: IAddressConverter {
    private var concreteConverters = [IAddressConverter]()

    func prepend(addressConverter: IAddressConverter) {
        concreteConverters.insert(addressConverter, at: 0)
    }

    func convert(address: String) throws -> Address {
        var errors = [Error]()

        for converter in concreteConverters {
            do {
                let converted = try converter.convert(address: address)
                return converted
            } catch {
                errors.append(error)
            }
        }

        throw BitcoinCoreErrors.AddressConversionErrors(errors: errors)
    }

    func convert(keyHash: Data, type: ScriptType) throws -> Address {
        var errors = [Error]()

        for converter in concreteConverters {
            do {
                let converted = try converter.convert(keyHash: keyHash, type: type)
                return converted
            } catch {
                errors.append(error)
            }
        }

        throw BitcoinCoreErrors.AddressConversionErrors(errors: errors)
    }

}
