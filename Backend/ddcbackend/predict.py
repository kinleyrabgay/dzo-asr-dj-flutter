import json
from datasets import load_dataset, Dataset,Audio
from transformers import Wav2Vec2ForCTC, Wav2Vec2Processor
from pyctcdecode import build_ctcdecoder
from transformers import Wav2Vec2ProcessorWithLM,AutoProcessor
import torch

def process_audio(filepath,model_id):

    print(filepath)

    model = Wav2Vec2ForCTC.from_pretrained("media/model/transformer/")
    processor = Wav2Vec2Processor.from_pretrained("media/model/transformer/")

    
    audio_file_path = [filepath]
    audio_data = Dataset.from_dict({"audio": audio_file_path}).cast_column("audio", Audio())
    audio_data = audio_data.cast_column("audio", Audio(sampling_rate=16_000))

    def prepare_dataset(batch):
        audio = batch["audio"]
        batch["input_values"] = processor(audio["array"], sampling_rate=audio["sampling_rate"]).input_values[0]
        batch["input_length"] = len(batch["input_values"])
        return batch

    test_dataset = audio_data.map(prepare_dataset)

    input_dict = processor(test_dataset[0]["input_values"], return_tensors="pt", padding=True)
    logits = model(input_dict.input_values).logits

    if (int(model_id)==1):
        pred_ids = torch.argmax(logits, dim=-1)[0]
        return processor.decode(pred_ids)
    
    elif (int(model_id)==2):
        processorLM = AutoProcessor.from_pretrained("media/model/transformer/")
        vocab_dict = processorLM.tokenizer.get_vocab()
        sorted_vocab_dict = {k.lower(): v for k, v in sorted(vocab_dict.items(), key=lambda item: item[1])}
        
      
        decoder = build_ctcdecoder(labels=list(sorted_vocab_dict.keys()), kenlm_model_path="media/model/transformer/5gram_correct.arpa",)
        processor_with_lm = Wav2Vec2ProcessorWithLM(feature_extractor=processor.feature_extractor,tokenizer=processorLM.tokenizer,decoder=decoder)

        outputstring = processor_with_lm.batch_decode(logits.detach().numpy()).text[0]
        print(outputstring)
        string_without_spaces = outputstring.replace(" ", "")
        stringlist = string_without_spaces.split("་")
        print(stringlist)
        whaitespacer=['གི','ཀྱི','གྱི','འི','ཡི','གིས','ཀྱིས','གྱིས','འིས','ཡིས']
        parsedstring=''
        for element in stringlist:
            if element in whaitespacer:
                parsedstring += element + "་ "
            else:
                parsedstring +=element+'་'
        
        return parsedstring[:len(parsedstring)-1]
    
    elif (int(model_id)==3):
        print("Using Distilled Model")
        model = Wav2Vec2ForCTC.from_pretrained("media/model/distilled83wer/")
        logits = model(input_dict.input_values).logits
        processorLM = AutoProcessor.from_pretrained("media/model/distilled83wer/")
        vocab_dict = processorLM.tokenizer.get_vocab()
        sorted_vocab_dict = {k.lower(): v for k, v in sorted(vocab_dict.items(), key=lambda item: item[1])}
        
      
        decoder = build_ctcdecoder(labels=list(sorted_vocab_dict.keys()), kenlm_model_path="media/model/transformer/5gram_correct.arpa",)
        processor_with_lm = Wav2Vec2ProcessorWithLM(feature_extractor=processor.feature_extractor,tokenizer=processorLM.tokenizer,decoder=decoder)

       
        return processor_with_lm.batch_decode(logits.detach().numpy()).text[0]
