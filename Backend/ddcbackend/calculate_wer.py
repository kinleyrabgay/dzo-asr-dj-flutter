from datasets import load_dataset, Dataset,Audio,load_metric
from transformers import Wav2Vec2ForCTC, Wav2Vec2Processor
import torch
from jiwer import wer
import pandas as pd

def process_audio(filepath):
    model = Wav2Vec2ForCTC.from_pretrained("Z:\/Notes\/7th sem\PRW401(IT) - Project Work\/app\Dzongkha-ASR-Data-Collection\/Backend\/media\/model\/distilled\/")
    processor = Wav2Vec2Processor.from_pretrained("Z:\/Notes\/7th sem\PRW401(IT) - Project Work\/app\Dzongkha-ASR-Data-Collection\/Backend\/media\/model\/distilled\/")
    # model = Wav2Vec2ForCTC.from_pretrained("media/model/789wer/")
    # processor = Wav2Vec2Processor.from_pretrained("media/model/789wer/")


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

    pred_ids = torch.argmax(logits, dim=-1)[0]
    

    return processor.decode(pred_ids)
    # print(processor.decode(pred_ids))


test_path = "Z:\/Notes\/7th sem\/PRW401(IT) - Project Work\/ASR Data\/train_test_dataset_8_2\/val_200.csv"
totalwer = 0
test_data = pd.read_csv(test_path)

print(len(test_data["path"]))
for i,x in enumerate(test_data["path"]):
    reference =test_data["transcript"][i]
    hypothesis = process_audio("Z:\/Notes\/7th sem\/PRW401(IT) - Project Work\/ASR Data\/Data Archive\/Final Dataset\/wav\/wav"+x+".wav")
    totalwer +=wer(reference,hypothesis)
    print(i)

print(totalwer/len(test_data["path"]))
